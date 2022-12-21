// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/firebase.dart';

class MemberprofileController extends GetxController {
  late List<DaftarKedalaman> kd;
  var isLoading = false.obs;

  RxList<dynamic> downlines = [].obs;

  var name = "[name]".obs;
  var memberCount = 0.obs;
  var kdstatus = 1.obs;
  var active = true.obs;
  var memberCreatedAt = Timestamp.now().obs;
  var birthday = Timestamp.now().obs;
  var whatsapp = "+62 818 818 818".obs;
  var email = "noname@noname.com".obs;
  var refid = "[refid]".obs;
  var address = "Jalan Raya Sidemen, Kabupaten Bangli, Bali 80552".obs;
  var bank = "BCA".obs;
  var rek = "123 123 132123 123132".obs;

  var uplineName = "[Upline Name]".obs;
  var uplineId = "uplineid".obs;

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

  Future<void> getMemberProfile(String id) async {
    final stopwatch = Stopwatch();
    isLoading.value = true;
    stopwatch.start();
    try {
      var member = (await Members.doc(id).get()).data()!;
      var memberInfo = (await MembersInfo.doc(id).get()).data()!;

      memberCount.value = memberInfo["memberCount"];
      kdstatus.value = memberInfo["downlines"]["kd"];
      active.value = member["active"];
      refid.value = member["tokenCode"];
      email.value = member["email"];
      whatsapp.value = member["whatsapp"];
      // print(member["birthdate"] as Timestamp);
      birthday.value = member["birthdate"] as Timestamp;
      address.value =
          "${member["address"]["jalan"]}, ${member["address"]["desa"]}, Kec. ${member["address"]["kec"]}, Kab. ${member["address"]["kab"]}, ${member["address"]["prov"]} ${member["address"]["kodepos"]}";
      rek.value = member["bankAcc"];
      bank.value = member["bank"];
      uplineName.value = memberInfo["uplineName"];
      uplineId.value = member["upline"];
      kd1count.value = int.parse(memberInfo["kd1count"].toString());

      downlines.value = jsonDecode(memberInfo["downlines"]["data"]);
      kd = generateItems(downlines.value.length, downlines.value);
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
