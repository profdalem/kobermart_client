import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/data/user_provider.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final authC = Get.find<AuthController>();
  late TextEditingController emailC;
  late TextEditingController passwordC;

  final box = GetStorage();

  var token = "".obs;

  final count = 0.obs;
  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    emailC.text = "agung@gmail.com";
    passwordC.text = "123456";
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
    print(box.read("token") == null);
  }
}
