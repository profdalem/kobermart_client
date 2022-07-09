import 'package:get/get.dart';

import '../controllers/trxdetail_transfer_controller.dart';

class TrxdetailTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailTransferController>(
      () => TrxdetailTransferController(),
    );
  }
}
