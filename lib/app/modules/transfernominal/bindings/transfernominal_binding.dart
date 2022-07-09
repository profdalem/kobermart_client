import 'package:get/get.dart';

import '../controllers/transfernominal_controller.dart';

class TransfernominalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransfernominalController>(
      () => TransfernominalController(),
    );
  }
}
