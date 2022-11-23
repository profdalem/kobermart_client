import 'package:get/get.dart';
import 'package:kobermart_client/app/data/iakprepaid_provider.dart';

class TrxdetailPrepaidController extends GetxController {
  RxList data = [].obs;
  @override
  void onInit() {
    print("init");
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

  Future<void> getStatus(String ref) async {
    await IakprepaidProvider().getStatus(ref).then((value) {
      data.add(value.body);
      data.refresh();
      return 0;
    });
  }
}
