import 'package:get/get.dart';
import '../../config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class BalanceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }

  // Top up section
  Future<Response> newTopup(String nominal, String method) async {
    var token;
    var userid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    final body = json.encode({
      "creator": userid,
      "id": userid,
      "nominal": int.parse(nominal),
      "method": method
    });

    return post(
      "${mainUrl}api/balance/topup",
      body,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }
}
