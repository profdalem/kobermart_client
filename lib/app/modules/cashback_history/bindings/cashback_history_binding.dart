import 'package:get/get.dart';

import '../controllers/cashback_history_controller.dart';

class CashbackHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashbackHistoryController>(
      () => CashbackHistoryController(),
    );
  }
}
