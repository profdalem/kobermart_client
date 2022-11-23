import 'package:get/get.dart';

import '../controllers/trxdetail_prepaid_controller.dart';

class TrxdetailPrepaidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailPrepaidController>(
      () => TrxdetailPrepaidController(),
    );
  }
}
