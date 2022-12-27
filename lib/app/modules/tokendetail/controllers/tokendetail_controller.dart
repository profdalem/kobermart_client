import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/models/Tokens.dart';
import 'package:kobermart_client/firebase.dart';

class TokendetailController extends GetxController {
  final count = 0.obs;
  var tokenCode = "".obs;
  var creator = "".obs;
  var upline = "".obs;
  var uplineName = "".obs;
  Rx<DateTime> createdAt = DateTime.now().obs;
  late Tokens data;

  @override
  Future<void> onInit() async {
    if (Get.arguments["data"] != null) {
      
      data = Get.arguments["data"];
      tokenCode.value = data.tokenReg;
      creator.value = (await data.getCreatorData())["name"];
      upline.value = data.uplineData["name"];
      createdAt.value = data.tokenCreatedAt;
    } else {
      await Members.doc(Get.arguments["tokenCode"]).get().then((doc) {
        tokenCode.value = doc.data()!["tokenReg"];
        creator.value = doc.data()!["tokenCreator"];
        upline.value = doc.data()!["upline"];
        createdAt.value = (doc.data()!["tokenCreatedAt"] as Timestamp).toDate();
      });
    }
    uplineName.value = await Members.doc(upline.value).get().then((value) => value.data()!["name"]);
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
}
