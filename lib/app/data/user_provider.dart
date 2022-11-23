import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:kobermart_client/config.dart';

class UserProvider extends GetConnect {
  Future<Response> login(String email, String password) async {
    print("login");
    final body =
        json.encode({"email": email, "password": password, "type": "1"});
    return await post(
      "${mainUrl}auth/login",
      body,
    );
  }

  Future<Response> getMe(String token) {
    return get("${mainUrl}auth/me",
        headers: {"Authorization": "Bearer ${token}"});
  }

  Future<Response> getInitialData() async {
    String token = "";
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) {
      token = value;
    });
    return get("${mainUrl}api/client/firstlogin",
        headers: {"Authorization": "Bearer ${token}"});
  }

  Future<Response> getMemberProfile(String id) async {
    String token = "";
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) {
      token = value;
    });
    return get("${mainUrl}api/client/memberprofile/${id}",
        headers: {"Authorization": "Bearer ${token}"});
  }

  Future<Response> getDownlines() async {
    String token = "";
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) {
      token = value;
    });
    return get("${mainUrl}api/client/downlines",
        headers: {"Authorization": "Bearer ${token}"});
  }

  Future<Response> getBalance() async {
    String token = "";
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) {
      token = value;
    });
    return get("${mainUrl}api/balance/mybalance",
        headers: {"Authorization": "Bearer ${token}"});
  }

  Future<Response> getCashback(String token) {
    return get("${mainUrl}api/cashback/mycashback",
        headers: {"Authorization": "Bearer ${token}"});
  }

  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }
}
