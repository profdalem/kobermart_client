import 'package:get/get.dart';

import '../controllers/ppob_pln_prepaid_controller.dart';

class PpobPlnPrepaidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PpobPlnPrepaidController>(
      () => PpobPlnPrepaidController(),
    );
  }
}
