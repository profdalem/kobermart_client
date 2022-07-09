import 'package:get/get.dart';

import '../controllers/trxdetail_cashback_controller.dart';

class TrxdetailCashbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailCashbackController>(
      () => TrxdetailCashbackController(),
    );
  }
}
