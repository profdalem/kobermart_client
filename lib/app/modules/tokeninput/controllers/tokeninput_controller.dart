import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokeninputController extends GetxController {
  late TextEditingController tokenC;

  final count = 0.obs;
  @override
  void onInit() {
    tokenC = TextEditingController();
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

  void increment() => count.value++;
}
