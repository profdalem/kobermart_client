import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/models/Member.dart';
import 'package:kobermart_client/app/models/Tokens.dart';
import 'package:kobermart_client/firebase.dart';
import '../../../../extensions.dart';

class TokenlistController extends GetxController {
  var authC = Get.find<AuthController>();
  var keyword = "".obs;
  RxList<Tokens> datalist = <Tokens>[].obs;
  RxList<Member> registeredDataList = <Member>[].obs;

  late TextEditingController searchC;
  late StreamSubscription memberSubs;

  var isLoading = false.obs;

  @override
  void onInit() {
    searchC = TextEditingController();
    memberSubs = Members.where("tokenCreator", isEqualTo: Auth.currentUser!.uid).snapshots().listen((event) async {
      isLoading.setTrue();
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            print("New: ${change.doc.data()}");
            if (change.doc.data()!["tokenUsed"]) {
              var data = Member.fromFirebaseSnapshot(change.doc);
              await data.getUplineData();
              registeredDataList.add(data);
            } else {
              var data = Tokens.fromFirebaseSnapshot(change.doc);
              await data.getUplineData();
              datalist.add(data);
            }
            break;
          case DocumentChangeType.modified:
            print("Modified: ${change.doc.data()}");
            var data = Tokens.fromFirebaseSnapshot(change.doc);
            await data.getUplineData();
            int index = datalist.indexWhere((element) => element.tokenCode == change.doc.id);
            datalist[index] = data;
            break;
          case DocumentChangeType.removed:
            print("Removed: ${change.doc.data()}");
            datalist.removeWhere((element) => element.tokenCode == change.doc.id);
            break;
        }
      }
      isLoading.setFalse();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    memberSubs.cancel().then((value) => print("memberSubs canceled"));
    super.onClose();
  }
}
