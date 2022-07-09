import 'package:get/get.dart';

class ItemController extends GetxController {
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
    if (count.value > 0) {
      count.value--;
    }
  }
}
