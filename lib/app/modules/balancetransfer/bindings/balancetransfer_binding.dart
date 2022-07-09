import 'package:get/get.dart';

import '../controllers/balancetransfer_controller.dart';

class BalancetransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalancetransferController>(
      () => BalancetransferController(),
    );
  }
}
