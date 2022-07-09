import 'package:get/get.dart';

import '../controllers/buynow_controller.dart';

class BuynowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuynowController>(
      () => BuynowController(),
    );
  }
}
