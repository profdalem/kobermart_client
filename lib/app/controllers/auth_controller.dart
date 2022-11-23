import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/modules/home/views/home_view.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/firebase.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  var isAuth = false.obs;
  var loading = false.obs;

  var kd1limit = 10.obs;
  var tokenprice = 200000.obs;

  Future<void> firstInitialized() async {
    await tokenExist().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<bool> tokenExist() async {
    if (box.read("token") != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    box.remove("token");
    box.remove("email");
    box.remove("password");
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> login(String email, String password) async {
    await Members.where("email", isEqualTo: email).get().then((value) {
      if (value.docs.isEmpty) {
        Get.snackbar("result", "Member tidak ditemukan");
      } else {
        if (value.docs[0]["active"]) {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) async {
            loading.value = false;
            isAuth.value = true;
            // await box.write("email", email);
            // await box.write("password", password);
            if (devMode)
              FirebaseAuth.instance.currentUser!.getIdToken(true).then((value) {
                print(value);
                // box.write("token", value);
              });

            Get.defaultDialog(
                barrierDismissible: false,
                content: Column(
                  children: [
                    Icon(Icons.check),
                    Text("Login berhasil"),
                  ],
                ));

            Future.delayed(Duration(milliseconds: 500)).then((value) =>
                Get.off(() => HomeView(), transition: Transition.zoom));
          }).catchError((error) {
            var message = "";
            switch (error.code) {
              case "user-not-found":
                message = "Pengguna tidak ditemukan";
                break;
              case "wrong-password":
                message = "Password salah";
                break;
              default:
                message = error.code;
            }
            Get.snackbar("Error", message.toString());
          });
        } else {
          Get.snackbar("result", "Member tidak aktif");
        }
        ;
      }
    }, onError: (e) {
      print(e);
    });

    // await UserProvider().login(email, password).then((value) {
    //   if (value.body != null) {
    //     box.write("token", value.body["token"]);
    //     print(box.read("token"));
    //     isAuth.value = true;
    //     Get.offAllNamed(Routes.HOME);
    //     loading.value = false;
    //   } else {
    //     loading.value = false;
    //     print(value.statusText);
    //     Get.defaultDialog(title: "Error", content: Text("Terjadi kesalahan"));
    //     // print(value.body["message"]);
    //   }
    // });
  }
}
