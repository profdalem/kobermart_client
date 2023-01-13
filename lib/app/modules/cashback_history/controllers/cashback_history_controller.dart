import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';

class CashbackHistoryController extends GetxController {
  final authC = Get.find<AuthController>();
  var startDate = DateTime.now().subtract(Duration(days: 7)).obs;
  var endDate = DateTime.now().obs;

  var cashback = [].obs;
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData() async {
    isLoading.value = true;
    await getCashbackHistory(authC.refId.value, startDate.value, endDate.value).then((value) {
      cashback.value = value;
    }).catchError((err) {
      print(err);
    });
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
