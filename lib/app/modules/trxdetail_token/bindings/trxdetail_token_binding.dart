import 'package:get/get.dart';

import '../controllers/trxdetail_token_controller.dart';

class TrxdetailTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailTokenController>(
      () => TrxdetailTokenController(),
    );
  }
}
