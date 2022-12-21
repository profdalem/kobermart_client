import 'package:get/get.dart';

import '../controllers/selectmethod_controller.dart';

class SelectmethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectmethodController>(
      () => SelectmethodController(),
    );
  }
}
