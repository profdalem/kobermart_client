// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';

class HomeController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  final authC = Get.find<AuthController>();
   var isLoading = false.obs;

  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    print("home is ready");

    // await FirebaseMessaging.instance.getToken().then((value) {
    //   Members.doc(authC.userCredential.value!.uid).set({"fcmToken": value}, SetOptions(merge: true));
    //   fcmToken = value!;
    // }).onError((error, stackTrace) {
    //   print(error.toString());
    // });
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }
}
