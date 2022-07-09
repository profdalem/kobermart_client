import 'package:get/get.dart';

import '../controllers/trxdetail_withdrawal_controller.dart';

class TrxdetailWithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailWithdrawalController>(
      () => TrxdetailWithdrawalController(),
    );
  }
}
