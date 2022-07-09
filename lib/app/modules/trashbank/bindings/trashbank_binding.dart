import 'package:get/get.dart';

import '../controllers/trashbank_controller.dart';

class TrashbankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrashbankController>(
      () => TrashbankController(),
    );
  }
}
