import 'package:get/get.dart';

class MembersController extends GetxController {
  late List<DaftarKedalaman> kd;
  @override
  void onInit() {
    super.onInit();
    kd = generateItems(5);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  List<DaftarKedalaman> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return DaftarKedalaman(
          header: "Kedalaman ${index}",
          isExpanded: index == 0 ? true.obs : false.obs);
    });
  }
}

class DaftarKedalaman {
  DaftarKedalaman({
    required this.header,
    required this.isExpanded,
  });

  String header;
  RxBool isExpanded;
}
