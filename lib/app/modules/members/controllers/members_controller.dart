import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';

class MembersController extends GetxController {
  var homeC = Get.find<HomeController>();

  late List<DaftarKedalaman> kd;
  @override
  void onInit() {
    super.onInit();
    kd = generateItems(homeC.downlines.length, homeC.downlines.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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
