import 'package:get/get.dart';

class ProductController extends GetxController {
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
