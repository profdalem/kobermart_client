import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';

class SettingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = mainUrl;
  }

  Future<Response> getLatestSetting() async {
    String token = "";
    httpClient.timeout = Duration(seconds: 30);

    await FirebaseAuth.instance.currentUser
        ?.getIdToken(true)
        .then((value) => {token = value});

    return get(
      "${mainUrl}api/setting/latest",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }
}
