import 'package:get/get.dart';

import '../controllers/tokenlist_controller.dart';

class TokenlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TokenlistController>(
      () => TokenlistController(),
    );
  }
}
