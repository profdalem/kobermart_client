import 'package:get/get.dart';

import '../controllers/memberhistory_controller.dart';

class MemberhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberhistoryController>(
      () => MemberhistoryController(),
    );
  }
}
