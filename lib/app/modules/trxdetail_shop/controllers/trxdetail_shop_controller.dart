import 'package:get/get.dart';

class TrxdetailShopController extends GetxController {
  final nominal = Get.arguments["nominal"];

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
  void testprint() {
    print(Get.arguments);
  }
}
