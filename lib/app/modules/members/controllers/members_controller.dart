// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/config.dart';

class MembersController extends GetxController {
  var homeC = Get.find<HomeController>();

  var isLoading = false.obs;

  List<DaftarKedalaman> kd = <DaftarKedalaman>[].obs;
  @override
  void onInit() {
    generateKd();
    super.onInit();
  }

  @override
  void onReady() {
    print("memberview ready");
    print(kd.isEmpty);
    if (kd.isEmpty) {
      generateKd();
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> generateKd() async {
    if (devMode) print("generate kd start");
    isLoading.value = true;
    kd = await generateItems(homeC.downlines.length, homeC.downlines.value).obs;
    isLoading.value = false;
  }

  List<DaftarKedalaman> generateItems(int numberOfItems, List downlines) {
    return List.generate(numberOfItems, (int index) {
      return DaftarKedalaman(
          header: "Kedalaman ${index}",
          isExpanded: index == 0 ? true.obs : false.obs,
          members: downlines[index]);
    });
  }
}

class DaftarKedalaman {
  DaftarKedalaman({
    required this.header,
    required this.isExpanded,
    required this.members,
  });

  String header;
  RxBool isExpanded;
  List<dynamic> members;
}
