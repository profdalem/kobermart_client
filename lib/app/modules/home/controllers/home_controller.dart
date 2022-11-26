// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/data/setting_provider.dart';
import 'package:kobermart_client/app/data/user_provider.dart';
import 'package:kobermart_client/config.dart';

import '../../../../firebase.dart';

class HomeController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  var isLoading = false.obs;

  var name = "".obs;
  var id = "".obs;
  var user;

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
  var fcmToken = "";

  final count = 0.obs;
  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    // await getBalance();
    // await getCashback();
    await getInitialData();
    await FirebaseMessaging.instance.getToken().then((value) {
      Members.doc(id.value).set({"fcmToken": value}, SetOptions(merge: true));
      fcmToken = value!;
    }).onError((error, stackTrace) {
      print(error.toString());
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message}');
      Get.defaultDialog(title: "Pesan", content: Text(message.data["body"]));
      name.value = message.data["title"];
      this.refresh();

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    print("home is ready");
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
      return b["memberData"]["tokenCreatedAt"]["_seconds"] - a["memberData"]["tokenCreatedAt"]["_seconds"];
    });
    sortedDownlines.value = temp;
  }

  Future<int> getBalance() async {
    int result = 0;
    await UserProvider().getBalance().then((value) {
      if (value.body["balance"] != null) {
        balance.value = value.body["balance"];
        result = balance.value;
      }
    });
    return result;
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
    if (devMode) Get.snackbar("GetDownlines Waktu", stopwatch.elapsed.toString());
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

      if (value.body["user"] != null) {
        user = value.body["user"];
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
