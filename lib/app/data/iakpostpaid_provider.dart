import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';
import 'package:kobermart_client/config.dart';

class IakpostpaidProvider extends GetConnect {
  @override
  void onInit() {
  }

  Future<Response> setInquiryPlnA(var hp) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/postpaid/pln/",
      {"code": "PLNPOSTPAID", "hp": hp, "refId": generateRandomString(6, "POSPLN")},
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

  Future<Response> setPayment(var trId, int nominal) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/postpaid/payment/",
      {
        "trId": trId,
        "nominal": nominal,},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }
}
