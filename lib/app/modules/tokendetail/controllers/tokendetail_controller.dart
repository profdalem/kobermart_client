import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/models/Tokens.dart';
import 'package:kobermart_client/firebase.dart';

class TokendetailController extends GetxController {
  final count = 0.obs;
  var tokenCode = "".obs;
  var tokenId = "".obs;
  var creator = "".obs;
  var upline = "".obs;
  var uplineName = "".obs;
  var uplineImgurl = "".obs;
  Rx<DateTime> createdAt = DateTime.now().obs;
  late Tokens data;

  @override
  Future<void> onInit() async {
      await Members.doc(Get.arguments["tokenCode"]).get().then((doc) {
        tokenCode.value = doc.data()!["tokenCode"];
        tokenId.value = doc.data()!["refId"];
        creator.value = doc.data()!["tokenCreator"];
        upline.value = doc.data()!["upline"];
        createdAt.value = (doc.data()!["tokenCreatedAt"] as Timestamp).toDate();
      });
      await Members.doc(upline.value).get().then((value) {
        uplineName.value = value.data()!["name"];
        uplineImgurl.value = value.data()!["imgurl"];
      });
    
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
