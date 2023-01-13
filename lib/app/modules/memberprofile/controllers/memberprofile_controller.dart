// ignore_for_file: invalid_use_of_protected_member
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/data/member_provider.dart';
import 'package:kobermart_client/app/modules/widgets/success_token.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:path_provider/path_provider.dart';

import '../../../helpers/general_helper.dart';

class MemberprofileController extends GetxController {
  final authC = Get.find<AuthController>();
  late List<DaftarKedalaman> kd;
  RxList<dynamic> downlines = [].obs;

  var isLoading = false.obs;
  var name = "[name]".obs;
  var memberCount = 0.obs;
  var kdstatus = 0.obs;
  var active = true.obs;
  var memberCreatedAt = Timestamp.now().obs;
  var birthday = Timestamp.now().obs;
  var whatsapp = "+62 818 818 818".obs;
  var email = "noname@noname.com".obs;
  var refid = "[refid]".obs;
  var imgurl = PROFILE_IMG.obs;
  var level = 0.obs;
  var address = "Jalan Raya Sidemen, Kabupaten Bangli, Bali 80552".obs;
  var bank = "BCA".obs;
  var rek = "123 123 132123 123132".obs;

  var uplineName = "[Upline Name]".obs;
  var uplineId = "uplineid".obs;
  var uplineIgmurl = PROFILE_IMG.obs;

  var kd1count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete();
    super.onClose();
  }

  void generateToken() {
    if (authC.settings["kd1limit"] == kd1count.value) {
      Get.defaultDialog(
        title: "Slot Penuh",
        content: Text("Slot di KD1 anda telah terisi semua"),
      );
    } else {
      Get.defaultDialog(
          barrierDismissible: true,
          title: "Konfirmasi",
          content: Center(
              child: Obx(
            () => isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text("Yakin buat token di KD1 ${name.value}?"),
          )),
          cancel: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Batal")),
          ),
          confirm: ElevatedButton(
              onPressed: () async {
                isLoading.value = true;
                await MemberProvider().newToken(refid.value, Auth.currentUser!.uid).then((value) async {
                  if (value.body["success"]) {
                    Get.back();
                    Get.to(() => SuccessTokenPage(), arguments: {"token": value.body["token"]});
                  } else {
                    Get.back();
                    isLoading.value = false;
                    Get.defaultDialog(title: "Gagal", content: Text(value.body["message"]));
                  }
                  isLoading.value = false;
                });
              },
              child: Text("Yakin")));
    }
  }

  List downlineList(String keyword) {
    List list = [];
    for (var i = 0; i < kdstatus.value; i++) {
      list.add([]);
    }
    downlines.forEach((element) {
      // print(element["level"] - (level.value+1));
      if (element["name"].toLowerCase().contains(keyword.trim().toLowerCase()) || element["uplineName"].toLowerCase().contains(keyword.trim().toLowerCase())) {
        list[element["level"] - (level.value + 1)].add(element);
      }
    });
    return list;
  }

  Future<void> getMemberProfile(String id) async {
    final stopwatch = Stopwatch();
    isLoading.value = true;
    stopwatch.start();
    try {
      var member = (await Members.doc(id).get()).data()!;
      var memberInfo = (await MembersInfo.doc(id).get()).data()!;
      var uplineInfo = (await Members.doc(member["upline"]).get()).data()!;
      final directory = await getApplicationDocumentsDirectory();
      final File downlinesData = File('${directory.path}/downlinesData${Auth.currentUser!.uid}.json');

      email.value = member["email"];
      whatsapp.value = member["whatsapp"];
      active.value = member["active"];
      refid.value = member["refId"];
      imgurl.value = member["imgurl"];
      birthday.value = toDateFormat(member["bday"], member["bmonth"], member["byear"]);
      memberCreatedAt.value = member["tokenCreatedAt"] as Timestamp;
      level.value = member["level"];

      address.value =
          "${capitalizeIt(member["address"]["jalan"])}, ${capitalizeIt(member["address"]["desa"])}, Kec. ${capitalizeIt(member["address"]["kec"])}, Kab. ${capitalizeIt(member["address"]["kab"])}, ${capitalizeIt(member["address"]["prov"])} ${capitalizeIt(member["address"]["kodepos"])}";
      rek.value = member["bankAcc"];
      bank.value = member["bank"];
      // print(member["birthdate"] as Timestamp);
      uplineName.value = memberInfo["uplineName"];
      uplineId.value = member["upline"];
      uplineIgmurl.value = uplineInfo["imgurl"];
      kd1count.value = memberInfo["kd1_member"] + memberInfo["kd1_token"];
      var mainDownlines = json.decode(await downlinesData.readAsString());
      var uplineMap = member["uplineMaps"][member["uplineMaps"].length - 1];
      mainDownlines.forEach((e) {
        e["uplineMaps"].forEach((el) {
          if (el == uplineMap + "-${refid.value}" && e["id"] != refid.value) {
            downlines.add(e);
          }
        });
      });

      if (downlines.isNotEmpty) {
        kdstatus.value = int.parse(downlines.value[0]["level"].toString()) - level.value;
        downlines.forEach((element) {
          if (kdstatus.value < (element["level"] - level.value)) {
            kdstatus.value = int.parse(element["level"].toString()) - level.value;
          }

          if (element["type"] == "member") {
            memberCount.value++;
          }
        });
      }
      // print(downlines.map((element) => element["level"]).toList());
      kd = generateItems(downlineList("").length, downlineList(""));
    } on FirebaseException catch (e) {
      print(e.message);
    }

    if (devMode) Get.snackbar("Waktu", stopwatch.elapsed.toString());
    isLoading.value = false;
    stopwatch.stop();
    stopwatch.reset();
  }

  List<DaftarKedalaman> generateItems(int numberOfItems, List downlines) {
    return List.generate(numberOfItems, (int index) {
      return DaftarKedalaman(header: "Kedalaman ${index}", isExpanded: index == 0 ? true.obs : false.obs, members: downlines[index]);
    });
  }
}

class DaftarKedalaman {
  DaftarKedalaman({
    required this.header,
    required this.isExpanded,
    required this.members,
  });

  String header;
  RxBool isExpanded;
  List<dynamic> members;
}
