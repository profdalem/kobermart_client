import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopupController extends GetxController {
  late TextEditingController nominal;
  var jumlah = 0.obs;
  String selectedMethod = "cash";

  @override
  void onInit() {
    nominal = TextEditingController();
    nominal.text = 0.toString();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nominal.dispose();
    super.onClose();
  }
}
