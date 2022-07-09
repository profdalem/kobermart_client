import 'package:get/get.dart';

import '../controllers/memberprofile_controller.dart';

class MemberprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<MemberprofileController>(
      () => MemberprofileController(),
    );
  }
}
