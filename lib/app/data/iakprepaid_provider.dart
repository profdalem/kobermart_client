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

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/pln/",
      {"customerId": customerId},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> setTopUpPln(
    var customerId,
    var refId,
    var productCode,
    var nominal,
    var customerData,
  ) async {
    var token;

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/topup/pln",
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

  Future<Response> setTopUpPaketData(var customerId, var refId, var productCode, var nominal, var productData) async {
    var token;

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/topup/data",
      {
        "customerId": customerId,
        "refId": refId,
        "productCode": productCode,
        "nominal": nominal,
        "productData": productData,
      },
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> setTopUpPulsa(var customerId, var refId, var productCode, var nominal) async {
    var token;

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/topup/pulsa",
      {
        "customerId": customerId,
        "refId": refId,
        "productCode": productCode,
        "nominal": nominal,
      },
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getPlnProduct() async {
    var token;
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return get(
      "${mainUrl}api/ppob/prepaid/pricelist/pln",
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getPaketDataPricelist() async {
    var token;
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/paketdata/operator",
      {},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getPulsaPricelist() async {
    var token;
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) => {token = value});

    return post(
      "${mainUrl}api/ppob/prepaid/pulsa/operator",
      {},
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getStatus(String ref) async {
    var token = await FirebaseAuth.instance.currentUser?.getIdToken(true).then((value) {
      return value;
    });

    return get(
      "${mainUrl}api/ppob/prepaid/status/${ref}",
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  }

  Future<Response> getPrepaidPricelist(var type, var operator) async {
   return post(
      "https://prepaid.iak.id/api/pricelist/${type}${"/"+operator}",
      {
        "username":"085237721290",
        "sign": iakSignPricelist,
        "status": "active"
      },
    );
  }
}
