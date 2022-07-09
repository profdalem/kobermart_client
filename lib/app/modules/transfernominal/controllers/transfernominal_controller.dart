import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransfernominalController extends GetxController {
  late TextEditingController nominal;
  var jumlah = 0.obs;
  final saldo = 2000000.obs;

  final count = 0.obs;
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
    super.onClose();
  }

  void increment() => count.value++;
  int getSaldo() {
    return saldo.value;
  }
}
