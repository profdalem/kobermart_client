// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';

import '../../../../config.dart';
import '../../../../firebase.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  final authC = Get.find<AuthController>();
   var isLoading = false.obs;

  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    await Auth.authStateChanges().listen((event) async {
      if (event == null) {
        devLog("User Logged out");
        authC.isAuth.value = false;
        if (authC.subscribeMemberInfo != null) {
          authC.subscribeMemberInfo.cancel();
          authC.subscribeSetting.cancel();
        }
        Get.toNamed(Routes.LOGIN);
      } else {
        devLog("Current user:" + event.uid);
        authC.setSubscribeMembersInfo();
        authC.setSubscribeSetting();
        await Members.doc(Auth.currentUser!.uid).get().then((value) {
          authC.level.value = value.data()!["level"];
          authC.imgurl.value = value.data()!["imgurl"];
        });
      }
    }, onError: (error) => Auth.signOut());
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
