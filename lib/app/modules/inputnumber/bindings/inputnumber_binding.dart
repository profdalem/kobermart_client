import 'package:get/get.dart';

import '../controllers/inputnumber_controller.dart';

class InputnumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputnumberController>(
      () => InputnumberController(),
    );
  }
}
