import 'package:get/get.dart';

import '../controllers/topup_controller.dart';

class TopupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopupController>(
      () => TopupController(),
    );
  }
}
