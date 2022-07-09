import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/data/user_provider.dart';

class HomeController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  var balance = 0.obs;
  var cashback = 0.obs;

  var box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    getBalance();
    getCashback();
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

  void getBalance() {
    UserProvider().getBalance(box.read("token")).then((value) {
      print(value.body);
      if (value.body["balance"] != null) {
        balance.value = value.body["balance"];
      }
    });
  }

  void getCashback() {
    UserProvider().getCashback(box.read("token")).then((value) {
      // print(value.body);
      if (value.body["cashback"] != null) {
        cashback.value = value.body["cashback"];
      }
    });
  }
}
