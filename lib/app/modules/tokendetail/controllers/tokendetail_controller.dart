import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/models/Tokens.dart';

class TokendetailController extends GetxController {
  final count = 0.obs;
  var tokenCode = "".obs;
  var creator = "".obs;
  var upline = "".obs;
  Rx<DateTime> createdAt = DateTime.now().obs;
  Tokens data = Get.arguments["data"];

  @override
  Future<void> onInit() async {
    super.onInit();
    tokenCode.value = data.tokenCode;
    creator.value = (await data.getCreatorData())["name"];
    upline.value = data.uplineData["name"];
    createdAt.value = data.tokenCreatedAt;
    print(upline.value);
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
}
