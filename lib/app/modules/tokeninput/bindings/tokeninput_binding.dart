import 'package:get/get.dart';

import '../controllers/tokeninput_controller.dart';

class TokeninputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TokeninputController>(
      () => TokeninputController(),
    );
  }
}
