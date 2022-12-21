import 'package:get/get.dart';

import '../../../data/member_provider.dart';

class NewtokenController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
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

  Future<dynamic> newToken(String upline, String ref) async {
    return await MemberProvider().newToken(upline, ref).then((value) => value.body);
  }
}
