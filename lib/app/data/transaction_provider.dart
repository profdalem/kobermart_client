import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../config.dart';

class TransactionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = mainUrlv2;
  }

  Future<Response> getUserTransactions(int days) async {
    String token = "";
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return get(
      "${mainUrlv2}api/transaction/${await FirebaseAuth.instance.currentUser!.uid}/${days.toString()}",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }
}
