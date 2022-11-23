import 'package:get/get.dart';

import '../controllers/trxdetail_postpaid_controller.dart';

class TrxdetailPostpaidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailPostpaidController>(
      () => TrxdetailPostpaidController(),
    );
  }
}
