import 'package:get/get.dart';

class MemberprofileController extends GetxController {
  late List<DaftarKedalaman> kd;

  final count = 0.obs;
  var userId = "Hello".obs;

  @override
  void onInit() {
    kd = generateItems(5);
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

  void increment() => count.value++;
  Future<void> printSomething(String something) async {
    print(something);
    userId.value = something;
  }

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
