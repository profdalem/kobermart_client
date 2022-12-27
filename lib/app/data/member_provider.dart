import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';

class MemberProvider extends GetConnect {
  Future<Response> setMember(dynamic body) async {
    var token;
    httpClient.timeout = Duration(seconds: 30);
    try {
      await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});
    } on FirebaseException catch (e) {
      print(e.message);
      Get.snackbar("Error", e.message!);
    }
    print("running");
    return post(
      "${mainUrl}api/member/member",
      body,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> registerMember(dynamic body) async {
    var token;
    httpClient.timeout = Duration(seconds: 30);
    try {
      await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});
    } on FirebaseException catch (e) {
      print(e.message);
      Get.snackbar("Error", e.message!);
    }
    print("running");
    return post(
      "${mainUrl}api/member/member",
      body,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> newToken(String upline, String ref) async {
    var token;
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    final body = json.encode({
      "ref": ref,
      "upline": upline,
    });
    return post(
      "${mainUrl}api/member/token",
      body,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }
}
