import 'package:get/get.dart';

import '../controllers/trxdetail_shop_controller.dart';

class TrxdetailShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrxdetailShopController>(
      () => TrxdetailShopController(),
    );
  }
}
