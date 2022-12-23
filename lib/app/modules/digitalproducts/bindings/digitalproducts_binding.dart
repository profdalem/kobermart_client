import 'package:get/get.dart';

import '../controllers/digitalproducts_controller.dart';

class DigitalproductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DigitalproductsController>(
      () => DigitalproductsController(),
    );
  }
}
