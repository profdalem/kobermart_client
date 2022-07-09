import 'package:get/get.dart';

import '../controllers/newtoken_controller.dart';

class NewtokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewtokenController>(
      () => NewtokenController(),
    );
  }
}
