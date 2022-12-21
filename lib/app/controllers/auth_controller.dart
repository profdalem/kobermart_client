import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/firebase.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  var isAuth = false.obs;
  var loading = false.obs;
  var isObsecure = true.obs;
  var rememberMe = false.obs;
  late TextEditingController emailC;
  late TextEditingController passwordC;

  Rx<User?> userCredential = FirebaseAuth.instance.currentUser.obs;

  var userBalance = 0.obs;

  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus.value = result;
  }

  Future<void> firstInitialized() async {
    print(boxStorage.read("rememberMe"));
    if (boxStorage.read("rememberMe") == null) {
      boxStorage.write("rememberMe", true);
    } else {
      rememberMe.value = boxStorage.read("rememberMe");
    }
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _connectivitySubscription.onData((data) async {
      connectionStatus.value = data;
      print(data);
      InternetAddress.lookup("google.com").then((value) {
        print('connected');
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }).catchError((onError) {
        print('not connected');
        Get.defaultDialog(title: "No Internet", content: Text("Koneksi internet terputus"), barrierDismissible: false);
      });
    });

    Auth.authStateChanges().listen((event) {
      print("Authstatechange");
      if (event == null) {
        Get.toNamed(Routes.LOGIN);
      }
    });

    emailC = TextEditingController();
    passwordC = TextEditingController();
    // checkToken();
    if (preFilled) emailC.text = "kobermart@gmail.com";
    if (preFilled) passwordC.text = "123456";
    await tokenExist().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<void> logout() async {
    Auth.signOut().then((value) {
      isAuth.value = false;
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  Future<bool> tokenExist() async {
    if (box.read("token") != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login(String email, String password) async {
    await Members.where("email", isEqualTo: email).get().then((value) async {
      if (value.docs.isEmpty) {
        Get.snackbar("result", "Member tidak ditemukan");
        devLog("Member tidak ditemukan");
        loading.value = false;
      } else {
        if (value.docs[0]["active"]) {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((UserCredential value) async {
              isAuth.value = true;
              if (rememberMe.value) {
                await boxStorage.write("email", email);
                await boxStorage.write("password", password);
              } else {
                await boxStorage.remove("email");
                await boxStorage.remove("password");
              }
              await boxStorage.write("rememberMe", rememberMe.value);
              userCredential.value = value.user!;
              emailC.text = "";
              passwordC.text = "";
              if (devMode)
                FirebaseAuth.instance.currentUser!.getIdToken(true).then((value) {
                  print(value);
                  // box.write("token", value);
                });

              Future.delayed(Duration(seconds: 1)).then((value) {
                loading.value = false;
                Get.offAllNamed(Routes.HOME, arguments: {"refresh": true});
              });
              Get.defaultDialog(
                  content: Column(
                children: [
                  Icon(Icons.check),
                  Text("Login berhasil"),
                ],
              ));
            }).catchError((error) {
              print(error.toString());
            });
          } on FirebaseAuthException catch (e) {
            var message = "";

            switch (e.code) {
              case "user-not-found":
                message = "Pengguna tidak ditemukan";
                break;
              case "wrong-password":
                message = "Password salah";
                break;
              default:
                message = e.code;
            }

            Get.snackbar("Error", message.toString());
            loading.value = false;
          }
        } else {
          Get.snackbar("result", "Member tidak aktif");
          loading.value = false;
        }
        ;
      }
    }).catchError((onError) {
      Get.snackbar("Error", "Error on login");
    });
  }
}
