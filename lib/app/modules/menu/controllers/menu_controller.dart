import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MenuController extends GetxController {
  final count = 0.obs;
  var appVersion = "version".obs;
  @override
  Future<void> onInit() async {
    setVersion();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setVersion() async {
    await PackageInfo.fromPlatform().then((value) => appVersion.value = value.version);
  }
}
