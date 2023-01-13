import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/config.dart';
import 'package:path_provider/path_provider.dart';

import '../../firebase.dart';

final box = GetStorage();
final authC = Get.find<AuthController>();

int nominalOnly(String text) {
  return int.parse(text.toString().replaceAll(new RegExp(r'[^0-9]'), ''));
}

String capitalizeIt(String word) {
  return word
      .toString()
      .trim()
      .split(" ")
      .map((e) {
        return e.capitalizeFirst;
      })
      .toList()
      .join(" ");
}

String generateRandomString(int len, String code) {
  var r = Random();
  const _chars = 'ABCDEFGHJKMNOPQRSTUVWXYZ1234567890';
  var _time = DateTime.now().year.toString().substring(2, 4) + DateTime.now().month.toString() + DateTime.now().day.toString();
  return code + _time + List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String segmentPower(String text) {
  var temp = text.split("/");
  var startSubtrim = 0;
  for (var i = 0; i < temp[1].length; i++) {
    if (temp[1][i] != "0") {
      startSubtrim = i;
      i = temp[1].length;
    }
  }
  return temp[0].trimLeft().trimRight() + "/" + temp[1].substring(startSubtrim, temp[1].length);
}

String censorHalf(String text) {
  var result = [];
  for (var i = 0; i < text.length; i++) {
    if (i < (text.length / 1.5).floor()) {
      result.add(text[i]);
    } else {
      result.add("*");
    }
  }
  return result.join();
}

String getPeriod(String text) {
  var year = text.substring(0, 4);
  var month = text.substring(4, 6);
  switch (month) {
    case "01":
      month = "Jan";
      break;
    case "02":
      month = "Feb";
      break;
    case "03":
      month = "Mar";
      break;
    case "04":
      month = "Apr";
      break;
    case "05":
      month = "Mei";
      break;
    case "06":
      month = "Jun";
      break;
    case "07":
      month = "Jul";
      break;
    case "08":
      month = "Ags";
      break;
    case "09":
      month = "Sept";
      break;
    case "10":
      month = "Okt";
      break;
    case "11":
      month = "Nov";
      break;
    default:
      month = "Des";
  }
  return month.toUpperCase() + " " + year;
}

Future<bool> internetCheck() async {
  var isConnected = false;
  await InternetAddress.lookup("google.com").then((value) {
    isConnected = true;
  }).catchError((onError) {
    isConnected = false;
  });
  return isConnected;
}

Future<void> serverSpeed(String url) async {
  Stopwatch time = Stopwatch();
  time.start();

  await InternetAddress.lookup(url).then((value) {
    print(url + ":" + time.elapsedMilliseconds.toString());
  }).catchError((onError) {
    print("invalid link");
  });
  time.stop();
}

Future<List> getUpdatedDownlines(String id) async {
  devLog("Starting get downlines ${id}");
  List downlines = [];
  final directory = await getApplicationDocumentsDirectory();
  final File downlinesData = File('${directory.path}/downlinesData${Auth.currentUser!.uid}.json');
  final downlinesUpdatedAt = await MembersInfo.doc(id).get().then((value) => (value.data()!["downlinesUpdatedAt"] as Timestamp).millisecondsSinceEpoch);
  print(downlinesUpdatedAt);

  box.remove("downlinesUpdatedAt${Auth.currentUser!.uid}");
  if (box.read("downlinesUpdatedAt${Auth.currentUser!.uid}") == null) {
    devLog("first initialized data");
    List temp = [];
    downlines = await Members.doc(id).get().then((me) async =>
        await Members.where("uplineMaps", arrayContains: me.data()!["uplineMaps"][me.data()!["uplineMaps"].length - 1].toString() + "-${id}")
            .get()
            .then((dls) => dls.docs
                .map((e) => {
                      "id": e.id,
                      "name": e.data()["tokenUsed"] ? e.data()["name"] : e.data()["tokenCode"],
                      "kd": e.data()["level"] - me.data()!["level"],
                      "level": e.data()["level"],
                      "upline": e.data()["upline"],
                      "tokenCreator": e.data()["tokenCreator"],
                      "uplineName": e.data()["uplineName"],
                      "uplineMaps": e.data()["uplineMaps"],
                      "tokenCode": e.data()["tokenCode"],
                      "type": e.data()["tokenUsed"] ? "member" : "token",
                      "imgurl": e.data()["imgurl"],
                      "createdAt": e.data()["tokenUsed"]
                          ? (e.data()["memberCreatedAt"] as Timestamp).millisecondsSinceEpoch
                          : (e.data()["tokenCreatedAt"] as Timestamp).millisecondsSinceEpoch,
                    })
                .toList()));

    for (var i = 0; i < downlines.length; i++) {
      await MembersInfo.doc(downlines[i]["id"]).get().then((value) {
        if (value.exists) {
          temp.add({"kd1_member": value.data()!["kd1_member"], "kd1_token": value.data()!["kd1_token"], ...downlines[i]});
        } else {
          temp.add(
            downlines[i],
          );
        }
      });
    }

    temp.sort((a, b) => a["createdAt"] - b["createdAt"]);
    temp.sort((a, b) => a["type"].compareTo(b["type"]));
    downlines = temp;

    downlinesData.writeAsString(json.encode(downlines));
    box.write("downlinesUpdatedAt${Auth.currentUser!.uid}", downlinesUpdatedAt);
  } else {
    if (downlinesUpdatedAt > box.read("downlinesUpdatedAt${Auth.currentUser!.uid}")) {
      devLog("get newest data");
      List temp = [];
      downlines = await Members.doc(id).get().then((me) async =>
          await Members.where("uplineMaps", arrayContains: me.data()!["uplineMaps"][me.data()!["uplineMaps"].length - 1].toString() + "-${id}")
              .where("updatedAt", isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(box.read("downlinesUpdatedAt${Auth.currentUser!.uid}")))
              .get()
              .then((dls) => dls.docs
                  .map((e) => {
                        "id": e.id,
                        "name": e.data()["tokenUsed"] ? e.data()["name"] : e.data()["tokenCode"],
                        "kd": e.data()["level"] - me.data()!["level"],
                        "level": e.data()["level"],
                        "upline": e.data()["upline"],
                        "uplineName": e.data()["uplineName"],
                        "tokenCreator": e.data()["tokenCreator"],
                        "uplineMaps": e.data()["uplineMaps"],
                        "tokenCode": e.data()["tokenCode"],
                        "type": e.data()["tokenUsed"] ? "member" : "token",
                        "imgurl": e.data()["imgurl"],
                        "createdAt": e.data()["tokenUsed"]
                            ? (e.data()["memberCreatedAt"] as Timestamp).millisecondsSinceEpoch
                            : (e.data()["tokenCreatedAt"] as Timestamp).millisecondsSinceEpoch,
                      })
                  .toList()));

      for (var i = 0; i < downlines.length; i++) {
        await MembersInfo.doc(downlines[i]["id"]).get().then((value) {
          if (value.exists) {
            temp.add({"kd1_member": value.data()!["kd1_member"], "kd1_token": value.data()!["kd1_token"], ...downlines[i]});
          } else {
            temp.add(
              downlines[i],
            );
          }
        });
      }

      temp.sort((a, b) => a["createdAt"] - b["createdAt"]);
      temp.sort((a, b) => a["type"].compareTo(b["type"]));

      downlines = json.decode(await downlinesData.readAsString());

      temp.forEach((tempEl) {
        downlines.removeWhere((downEl) => downEl["id"] == tempEl["id"]);
      });

      downlines = [...temp, ...downlines];
      downlinesData.writeAsString(json.encode(downlines));
      box.write("downlinesUpdatedAt${Auth.currentUser!.uid}", downlinesUpdatedAt);
    } else {
      devLog("no new data");
      downlines = json.decode(await downlinesData.readAsString());
    }
  }

  downlines = json.decode(await downlinesData.readAsString());
  var kdcount = 0;
  var memberCount = 0;
  downlines.forEach((e) {
    if (e["kd"] > kdcount) {
      kdcount = e["kd"];
    }
    if (e["type"] == "member") {
      memberCount++;
    }
  });
  authC.kd.value = kdcount;
  authC.anggota.value = memberCount;
  print("get downline done");
  return downlines;
}

Timestamp toDateFormat(day, month, year) {
  return Timestamp.fromDate(DateTime(int.parse(year.toString()), int.parse(month.toString())).add(Duration(days: int.parse(day.toString()) - 1)));
}

String hideText(String text) {
  var result = [];

  for (var i = 0; i < text.length; i++) {
    result.add("*");
  }

  return result.join();
}

List getSearchResult(String keyword, int kd) {
  List result = [];
  if (kd == 0) {
    authC.downlines.forEach((element) {
      if (element["type"] == "member" && element["name"].toString().toLowerCase().trim().contains(keyword.toLowerCase().trim())) {
        result.add(element);
      }
    });
  } else {
    authC.downlines.forEach((element) {
      if (element["type"] == "member" && element["kd"] == kd && element["name"].toString().toLowerCase().trim().contains(keyword.toLowerCase().trim())) {
        result.add(element);
      }
    });
  }
  return result;
}

Future<List> getCashbackHistory(String id, DateTime startDate, DateTime endDate) async {
  List datelist = [];
  List cashbacks = [];
  try {
    await GlobalTrx.where("type", whereIn: ["plan-a", "plan-b", "referral"])
        .where("id", isEqualTo: id)
        .where("status", isEqualTo: "ACTIVE")
        .where("createdAt", isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where("createdAt", isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy("createdAt", descending: true)
        .get()
        .then((value) {
      if (value.size > 0) {
        datelist = value.docs
            .map((e) =>
                "${(e["createdAt"] as Timestamp).toDate().year.toString()}-${(e["createdAt"] as Timestamp).toDate().month.toString().padLeft(2, "0")}-${(e["createdAt"] as Timestamp).toDate().day.toString().padLeft(2, "0")}")
            .toList()
            .toSet()
            .toList();
        cashbacks = value.docs
            .map((e) => {
                  "nominal": e["nominal"],
                  "type": e["type"],
                  "createdAt":
                      "${(e["createdAt"] as Timestamp).toDate().year.toString()}-${(e["createdAt"] as Timestamp).toDate().month.toString().padLeft(2, "0")}-${(e["createdAt"] as Timestamp).toDate().day.toString().padLeft(2, "0")}",
                })
            .toList();
      } else {
        print("result is null");
        return [];
      }
    });
  } on FirebaseFirestore catch (e) {
    print(e);
  }

  var result = [];

  for (var i = 0; i < datelist.length; i++) {
    int cba = 0;
    int cbb = 0;
    int ref = 0;
    for (var j = 0; j < cashbacks.length; j++) {
      if (cashbacks[j]["createdAt"] == datelist[i]) {
        if (cashbacks[j]["type"] == "referral") {
          ref += int.parse(cashbacks[j]["nominal"].toString());
        }
        if (cashbacks[j]["type"] == "plan-a") {
          cba += int.parse(cashbacks[j]["nominal"].toString());
        }
        if (cashbacks[j]["type"] == "plan-b") {
          cbb += int.parse(cashbacks[j]["nominal"].toString());
        }
      }
    }
    result.add({"date": datelist[i], "ref": ref, "cba": cba, "cbb": cbb, "sum": ref + cba + cbb});
  }
  print(result);

  return result;
}
