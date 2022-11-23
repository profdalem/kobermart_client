import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/product_controller.dart';
import 'package:kobermart_client/app/modules/cart/controllers/cart_controller.dart';

class ItemController extends GetxController {
  var cartC = Get.find<CartController>();
  var productC = Get.find<MainProductController>();
  var count = 0.obs;
  var price = 0.obs;
  var id = "";
  var stock = 0;

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

  void increment() {
    if (count.value + 1 > stock) {
      Get.defaultDialog(
          title: "Stok kurang",
          content: Text("Stok tersisa: ${stock.toString()}"));
    } else {
      cartC.totalprice.value -= (count.value * price.value);
      count.value++;
      cartC.totalprice.value += (count.value * price.value);
    }
  }

  void decrement() {
    if (count.value > 0) {
      cartC.totalprice.value -= (count.value * price.value);
      count.value--;
      cartC.totalprice.value += (count.value * price.value);
    }
  }
}
