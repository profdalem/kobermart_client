import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PpobController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Listrik'),
    const Tab(
      text: 'Pulsa',
    ),
    const Tab(text: 'Internet'),
  ];

  late TabController tabC;

  @override
  void onInit() {
    tabC = TabController(length: 3, vsync: this);
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
}
