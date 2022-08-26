import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/data/user_provider.dart';

class HomeController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  var name = "".obs;

  var balance = 0.obs;
  var cashback = 0.obs;
  var anggota = 0.obs;
  var kd = 0.obs;

  var box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    // await getBalance();
    // await getCashback();
    await getInitialData();
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

  Future<void> getBalance() async {
    await UserProvider().getBalance(box.read("token")).then((value) {
      print(value.body);
      if (value.body["balance"] != null) {
        balance.value = value.body["balance"];
      }
    });
  }

  Future<void> getCashback() async {
    await UserProvider().getCashback(box.read("token")).then((value) {
      // print(value.body);
      if (value.body["cashback"] != null) {
        cashback.value = value.body["cashback"];
      }
    });
  }

  Future<void> getInitialData() async {
    if (box.read("token") != null) {
      await UserProvider().getInitialData(box.read("token")).then((value) {
        if (value.body["user"] != null) {
          name.value = value.body["user"]["name"];
        }

        if (value.body["cashback"] != null) {
          cashback.value = value.body["cashback"];
        }

        if (value.body["balance"] != null) {
          balance.value = value.body["balance"];
        }

        if (value.body["downlines"] != null) {
          anggota.value = value.body["downlines"]["count"];
        }

        if (value.body["downlines"] != null) {
          kd.value = value.body["downlines"]["kd"];
        }
      });
    }
  }
}
