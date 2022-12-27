import 'package:get/get.dart';
import 'package:kobermart_client/firebase.dart';
import '../../config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class BalanceProvider extends GetConnect {
  @override
  void onInit() {
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

  // Withdraw section
  Future<Response> newWithdraw(String nominal, String method) async {
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
      "${mainUrl}api/balance/withdraw",
      body,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  // Transfer section
  Future<Response> newTransfer(String recipient, String nominal) async {
    var token;
    var userid = Auth.currentUser!.uid;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    final body = json.encode({
      "sender": userid,
      "recipient": recipient,
      "nominal": int.parse(nominal),
    });

    return post(
      "${mainUrl}api/balance/transfer",
      body,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }
}
