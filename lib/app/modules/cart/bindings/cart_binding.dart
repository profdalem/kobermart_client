import 'package:get/get.dart';

import 'package:kobermart_client/app/modules/cart/controllers/item_controller.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<ItemController>(
      () => ItemController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
