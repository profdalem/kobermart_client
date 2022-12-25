import 'package:get/get.dart';

import '../controllers/ppob_pln_postpaid_controller.dart';

class PpobPlnPostpaidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PpobPlnPostpaidController>(
      () => PpobPlnPostpaidController(),
    );
  }
}
