// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/config.dart';

class MembersController extends GetxController {
  var authC = Get.find<AuthController>();

  var isLoading = false.obs;
  var keyword = "".obs;
  late TextEditingController searchC;

  List<DaftarKedalaman> kd = <DaftarKedalaman>[].obs;
  @override
  void onInit() {
    searchC = TextEditingController();
    generateKd();
    super.onInit();
  }

  @override
  void onReady() {
    generateKd();
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  Future<void> generateKd() async {
    devLog("generate kd start");
    isLoading.value = true;
    if (authC.downlines.isEmpty) {
      try {
        kd = await generateItems(authC.downlineList(keyword.value).length, authC.downlineList(keyword.value)).obs;
      } on FirebaseException catch (e) {
        print(e.message);
      }
    } else {
      kd = await generateItems(authC.downlineList(keyword.value).length, authC.downlineList(keyword.value)).obs;
    }
    isLoading.value = false;
  }

  List<DaftarKedalaman> generateItems(int numberOfItems, List downlines) {
    return List.generate(numberOfItems, (int index) {
      return DaftarKedalaman(header: "Kedalaman ${index}", isExpanded: index == 0 ? true.obs : false.obs, members: downlines[index]);
    });
  }
}

class DaftarKedalaman {
  DaftarKedalaman({
    required this.header,
    required this.isExpanded,
    required this.members,
  });

  String header;
  RxBool isExpanded;
  List<dynamic> members;
}
