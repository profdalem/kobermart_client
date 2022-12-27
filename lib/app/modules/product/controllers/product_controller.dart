import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final count = 10.obs;
  var page = 1.obs;

  final ScrollController slide = ScrollController();
  @override
  void onInit() {
    slide.addListener(() {
      page.value = (slide.offset / Get.width).floor() + 1;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    slide.dispose();
    slide.removeListener(() {});
    super.onClose();
  }

  void increment() => count.value++;
  void decrement() {
    if (count > 0) {
      count.value--;
    }
  }

  void tenIncrement() => count.value = count.value + 10;
  void tenDecrement() {
    if (count > 9) {
      count.value = count.value - 10;
    }
  }
}
