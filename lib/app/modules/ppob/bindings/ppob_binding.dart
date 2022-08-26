import 'package:get/get.dart';

import '../controllers/ppob_controller.dart';

class PpobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PpobController>(
      () => PpobController(),
    );
  }
}
