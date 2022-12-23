import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

class DigitalproductsController extends GetxController {
  

  List<Map<String, dynamic>> products = [
    {
      "name": "Pulsa",
      "icon": Icon(
        Icons.phone_android_outlined,
        color: Colors.blue.shade700,
      ),
      "icon_bg": Colors.blue.shade100,
      "action": () => Get.toNamed(Routes.PPOB_PULSADATA, arguments: {"product": "pulsa"}),
    },
    {
      "name": "Paket Data",
      "icon": Icon(
        Icons.wifi,
        color: Colors.green.shade500,
      ),
      "icon_bg": Colors.green.shade100,
      "action": () => Get.toNamed(Routes.PPOB_PULSADATA, arguments: {"product": "data"}),
    },
    {
      "name": "Token Listrik",
      "icon": Icon(
        Icons.electric_bolt,
        color: Colors.amber.shade700,
      ),
      "icon_bg": Colors.yellow.shade200,
      "action": () => Get.toNamed(Routes.INVESTMENT),
    },
    {
      "name": "Tagihan Listrik",
      "icon": Icon(
        Icons.electric_bolt,
        color: Colors.amber.shade700,
      ),
      "icon_bg": Colors.yellow.shade200,
      "action": () => Get.toNamed(Routes.INVESTMENT),
    },
  ];

  final count = 0.obs;
  @override
  void onInit() {
    
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
