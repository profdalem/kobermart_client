import 'package:get/get.dart';

import '../controllers/trxdetail_topup_controller.dart';

class TrxdetailTopupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailTopupController>(
      () => TrxdetailTopupController(),
    );
  }
}
