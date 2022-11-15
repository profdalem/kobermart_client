import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class TokenlistController extends GetxController {
  var homeC = Get.find<HomeController>();
  var keyword = "".obs;

  late TextEditingController searchC;

  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
