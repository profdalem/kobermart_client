import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/config.dart';

class LoginController extends GetxController {
  final authC = Get.find<AuthController>();
  late TextEditingController emailC;
  late TextEditingController passwordC;

  final box = GetStorage();

  var token = "".obs;
  var loading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    checkToken();
    if (preFilled) emailC.text = "kobermart@gmail.com";
    if (preFilled) passwordC.text = "123456";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();

    super.onClose();
  }

  void checkToken() {
    print("storage data:");
    print(box.read("token"));
    print(box.read("email"));
    print(box.read("password"));
  }
}
