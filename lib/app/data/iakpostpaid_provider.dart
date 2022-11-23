import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';

class IakpostpaidProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }

  Future<Response> setInquiryPlnA(var hp, var refId) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/postpaid/pln/",
      {"code": "PLNPOSTPAID", "hp": hp, "refId": refId},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> setInquiryPlnB(var hp, var refId) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/postpaid/pln/",
      {"code": "PLNPOSTPAIDB", "hp": hp, "refId": refId},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> setPayment(var trId, var refId, var hp) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/postpaid/payment/",
      {
        "trId": trId,
        "refId": refId,
        "hp": hp,
      },
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }
}
