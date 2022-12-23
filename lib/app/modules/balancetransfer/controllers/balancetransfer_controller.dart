import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalancetransferController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var keyword = "".obs;
  late TextEditingController searchC;
  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
