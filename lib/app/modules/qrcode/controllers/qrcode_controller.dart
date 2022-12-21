import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/firebase.dart';

class QrcodeController extends GetxController {
  var qrcode = "".obs;
  var expired = 0.obs;
  @override
  void onInit() {
    generateCodes();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void generateCodes() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    DateTime now = DateTime.now();
    Random _rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    qrcode.value = getRandomString(20);
    expired.value = now.add(Duration(seconds: 15)).millisecondsSinceEpoch;
    MembersInfo.doc(Auth.currentUser!.uid).set({
      "validation": {
        "code": qrcode.value,
        "expired": Timestamp.fromMillisecondsSinceEpoch(expired.value),
      }
    }, SetOptions(merge: true));
    devLog(qrcode.value);
    devLog(expired.value);
  }
}
