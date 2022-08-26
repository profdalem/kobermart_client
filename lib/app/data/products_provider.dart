import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';

class ProductsProvider extends GetConnect {
  Future<Response> getProducts() async {
    String token = "";

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return get(
      "${mainUrl}api/shop/product",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  Future<Response> getCarts() async {
    String token = "";

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return get(
      "${mainUrl}api/shop/cart",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }
}
