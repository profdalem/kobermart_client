import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/firebase.dart';

class TokeninputController extends GetxController {
  late TextEditingController tokenC;

  final count = 0.obs;
  @override
  void onInit() {
    tokenC = TextEditingController();
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

  Future<dynamic> validateToken() async {
    bool success = false;
    String id = "";
    String message = "Token tidak valid";
    await Members.where("tokenCode", isEqualTo: tokenC.text).where("tokenUsed", isEqualTo: false).limit(1).get().then((value) {
      if (value.size > 0) {
        success = true;
        id = value.docs[0]["tokenCode"];
        message = "Token valid";
      }
    }).catchError(((err) {
      print(err);
    }));

    return {"success": success, "id": id, "message": message};
  }
}
