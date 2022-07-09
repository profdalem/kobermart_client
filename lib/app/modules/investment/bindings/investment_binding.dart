import 'package:get/get.dart';

import '../controllers/investment_controller.dart';

class InvestmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestmentController>(
      () => InvestmentController(),
    );
  }
}
