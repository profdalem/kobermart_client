import 'package:get/get.dart';

import '../controllers/ppob_pulsadata_controller.dart';

class PpobPulsadataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PpobPulsadataController>(
      () => PpobPulsadataController(),
    );
  }
}
