import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/member_provider.dart';

class NewtokenController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var keyword = "".obs;
  late TextEditingController searchC;
  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  Future<dynamic> newToken(String upline, String ref) async {
    print(upline);
    print(ref);
    return await MemberProvider().newToken(upline, ref).then((value) => value.body);
  }
}
