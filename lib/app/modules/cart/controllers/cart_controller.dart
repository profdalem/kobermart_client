import 'package:get/get.dart';

class CartController extends GetxController {
  RxList carts = [].obs;

  late RxList products;

  var count = 0.obs;
  var totalprice = 0.obs;

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
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }
}
