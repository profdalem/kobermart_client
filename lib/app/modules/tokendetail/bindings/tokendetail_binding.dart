import 'package:get/get.dart';

import '../controllers/tokendetail_controller.dart';

class TokendetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TokendetailController>(
      () => TokendetailController(),
    );
  }
}
