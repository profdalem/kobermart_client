import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';

class IakprepaidProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }

  Future<Response> setInquiryPln(var customerId) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/pln/",
      {"customerId": customerId},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> setTopUp(var customerId, var refId, var productCode,
      var nominal, var customerData) async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/topup/",
      {
        "customerId": customerId,
        "refId": refId,
        "productCode": productCode,
        "nominal": nominal,
        "customerData": customerData,
      },
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getPlnProduct() async {
    var token;

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return get(
      "${mainUrl}api/ppob/prepaid/pricelist/pln",
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getStatus(String ref) async {
    var token =
        await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) {
      return value;
    });

    return get(
      "${mainUrl}api/ppob/prepaid/status/${ref}",
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }
}
