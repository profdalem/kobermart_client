import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/data/setting_provider.dart';
import 'package:kobermart_client/app/data/user_provider.dart';
import 'package:kobermart_client/config.dart';

class HomeController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  var isLoading = false.obs;

  var name = "".obs;
  var id = "".obs;

  var balance = 0.obs;
  var cashback = 0.obs;
  var anggota = 0.obs;
  var kd = 0.obs;
  var kd1count = 0.obs;
  var upline;

  var settings;

  RxList downlines = [].obs;
  RxList sortedDownlines = [].obs;

  var box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    // await getBalance();
    // await getCashback();
    getInitialData();
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

  void sortDownlines() {
    List<dynamic> temp = [];
    for (var i = 0; i < downlines.value.length; i++) {
      for (var j = 0; j < downlines.value[i].length; j++) {
        temp.add(downlines.value[i][j]);
      }
    }
    temp.sort((a, b) {
      return b["memberData"]["tokenCreatedAt"]["_seconds"] -
          a["memberData"]["tokenCreatedAt"]["_seconds"];
    });
    sortedDownlines.value = temp;
  }

  Future<void> getBalance() async {
    await UserProvider().getBalance(box.read("token")).then((value) {
      // print(value.body);
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

  Future<void> getDownlines() async {
    isLoading.value = true;
    final stopwatch = Stopwatch();
    stopwatch.start();

    await UserProvider().getDownlines().then((value) {
      if (value.body["downlines"] != null) {
        kd.value = int.parse(value.body["downlines"]["kd"].toString());
        downlines.value = value.body['downlines']['data'];
      }

      if (value.body["kd1count"] != null) {
        kd1count.value = int.parse(value.body["kd1count"].toString());
      }
    }).catchError((error) {
      print("getInitialData error: " + error.toString());
    });
    sortDownlines();
    if (devMode)
      Get.snackbar("GetDownlines Waktu", stopwatch.elapsed.toString());
    stopwatch.stop();
    stopwatch.reset();
    isLoading.value = false;
  }

  Future<void> getInitialData() async {
    if (devMode) print("starting getInitialData");
    isLoading.value = true;
    final stopwatch = Stopwatch();
    stopwatch.start();
    await UserProvider().getInitialData().then((value) {
      if (value.body["user"] != null) {
        name.value = value.body["user"]["name"];
      }

      if (value.body["id"] != null) {
        id.value = value.body["id"];
      }

      if (value.body["upline"] != null) {
        upline = value.body["upline"];
      }

      if (value.body["kd1count"] != null) {
        kd1count.value = int.parse(value.body["kd1count"].toString());
      }

      if (value.body["cashback"] != null) {
        cashback.value = int.parse(value.body["cashback"].toString());
      }

      if (value.body["balance"] != null) {
        balance.value = int.parse(value.body["balance"].toString());
      }

      if (value.body["downlines"] != null) {
        anggota.value = int.parse(value.body["memberCount"].toString());
      }

      if (value.body["downlines"] != null) {
        kd.value = int.parse(value.body["downlines"]["kd"].toString());
        downlines.value = value.body['downlines']['data'];
      }
    }).catchError((error) {
      print("getInitialData error: " + error.toString());
    });

    await SettingProvider().getLatestSetting().then((value) {
      if (value.statusCode == 200) {
        settings = value.body;
      }
    });

    sortDownlines();

    if (devMode) Get.snackbar("Waktu", stopwatch.elapsed.toString());
    stopwatch.stop();
    stopwatch.reset();
    isLoading.value = false;
  }
}
