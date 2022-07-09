import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

import '../data/user_provider.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  var isAuth = false.obs;

  Future<void> firstInitialized() async {
    await tokenExist().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<bool> tokenExist() async {
    if (box.read("token") != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    box.remove("token");
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> login(String email, String password) async {
    UserProvider().login(email, password).then((value) {
      if (value.body["token"] != null) {
        box.write("token", value.body["token"]);
        print(box.read("token"));
        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(title: "Error", content: Text(value.body["message"]));
        print(value.body["message"]);
        print(box.read('token'));
      }
    });
  }
}
