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
    var success = false;
    var message = "Gagal membuat token baru";
    var token = "-";
    await MemberProvider().newToken(upline, ref).then((value) async {
      if (value.body != null) {
        if (value.body["success"]) {
          print("here");
          success = true;
          token = value.body["token"];
        }
        message = value.body["message"];
      }
    }).catchError((e) {
      message = e.toString();
    });

    return {"success": success, "message": message, "token": token};
  }
}
