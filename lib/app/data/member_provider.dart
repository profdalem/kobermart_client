import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';

class MemberProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }

  Future<Response> setMember(var body) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

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

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    final body = json.encode({
      "upline": upline,
      "ref": ref,
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
