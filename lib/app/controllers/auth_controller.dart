import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/error.dart';
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
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();

  // Current user data
  Rx<User?> userCredential = FirebaseAuth.instance.currentUser.obs;
  var name = "".obs;
  var refId = "".obs;
  var balance = 0.obs;
  var cashback = 0.obs;
  var anggota = 0.obs;
  var kd = 0.obs;
  var level = 0.obs;
  var kd1_member = 0.obs;
  var kd1_token = 0.obs;
  var uplineName = "".obs;
  var fcmToken = "";
  var imgurl = "".obs;
  var settings;
  RxList downlines = [].obs;

  var subscribeMemberInfo = MembersInfo.doc().snapshots().listen((event) {});
  var subscribeSetting = AppSettings.doc("latest").snapshots().listen((event) {});

  @override
  void onInit() {
    subscribeSetting.onData((event) {
      devLog("setting changed");
      settings = event.data();
    });
    subscribeSetting.onError((error) {
      print(error);
    });
    subscribeMemberInfo.pause();
    refId.listen(
      (event) {
        if (event.isEmpty) {
          subscribeMemberInfo.cancel();
        } else {
          setSubscribeMembersInfo();
        }
      },
    );
    firstInitialized();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    subscribeSetting.cancel();
    subscribeMemberInfo.cancel();
    refId.close();
    super.onClose();
  }

  void checker() {
    Get.defaultDialog(
        content: Column(
      children: [
        if (Auth.currentUser != null) Text(Auth.currentUser!.email.toString()),
        Text(isAuth.toString()),
        Text(refId.toString()),
      ],
    ));
  }

  Future<void> firstInitialized() async {
    print("auth first initialized");
    emailC = TextEditingController();
    passwordC = TextEditingController();

    if (Auth.currentUser != null) {
      userCredential.value = Auth.currentUser;
      try {
        await Members.doc(Auth.currentUser!.uid).get().then((value) {
          level.value = value.data()!["level"];
          imgurl.value = value.data()!["imgurl"];
          refId.value = value.id;
        });
      } on FirebaseException catch (e) {
        print(e.message);
      }
    } else {
      isAuth.value = false;
    }

    if (box.read("rememberMe") == null) {
      box.write("rememberMe", true);
    } else {
      rememberMe.value = box.read("rememberMe");
    }

    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    await Future.delayed(
        Duration(seconds: 5),
        (() => _connectivitySubscription.onData((data) async {
              connectionStatus.value = data;
              InternetAddress.lookup("google.com").then((value) {
                print('connected');
                if (Get.isDialogOpen!) {
                  Get.back();
                }
              }).catchError((onError) {
                print('not connected');
                if (!Get.isDialogOpen!) {
                  Get.defaultDialog(title: "No Internet", content: Text("Koneksi internet terputus"), barrierDismissible: false);
                }
              });
            })));

    if (preFilled) emailC.text = "kobermart@gmail.com";
    if (preFilled) passwordC.text = "123456";
  }

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

  Future<void> logout() async {
    Auth.signOut().then((value) {
      isAuth.value = false;
      refId.value = "";
      Get.offAllNamed(Routes.LOGIN);
    });
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
              refId.value = value.user!.uid;
              if (rememberMe.value) {
                await box.write("email", email);
                await box.write("password", password);
              } else {
                await box.remove("email");
                await box.remove("password");
              }
              await box.write("rememberMe", rememberMe.value);
              userCredential.value = value.user!;
              emailC.text = "";
              passwordC.text = "";
              if (devMode)
                FirebaseAuth.instance.currentUser!.getIdToken(true).then((value) {
                  print(value);
                  // box.write("token", value);
                });

              Future.delayed(Duration(seconds: 1)).then((value) async {
                loading.value = false;
                setSubscribeMembersInfo();
                await Members.doc(Auth.currentUser!.uid).get().then((value) {
                  level.value = value.data()!["level"];
                  imgurl.value = value.data()!["imgurl"];
                  refId.value = value.id;
                });
                Get.offAllNamed(Routes.HOME, arguments: {"refresh": true});
              });
              Get.defaultDialog(
                  content: Column(
                children: [
                  Icon(Icons.check),
                  Text("Login berhasil"),
                ],
              ));
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
            print(e);
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

  void setSubscribeMembersInfo() async {
    subscribeMemberInfo.cancel();
    subscribeMemberInfo = MembersInfo.doc(refId.value).snapshots().listen(
      (event) async {
        print("changed");
        anggota.value = 0;
        var data = event.data()!;
        print(data["balance"]);
        refId.value = event.id;
        uplineName.value = data["uplineName"];
        kd1_member.value = data["kd1_member"];
        kd1_token.value = data["kd1_token"];
        cashback.value = data["cashback"];
        balance.value = data["balance"];
        downlines.value = data["downlines"];

        if (downlines.isNotEmpty) {
          kd.value = downlines[0]["level"] - level.value;
          downlines.forEach((element) {
            if (kd.value < (element["level"] - level.value)) {
              kd.value = element["level"] - level.value;
            }

            if (element["type"] == "member") {
              anggota.value++;
            }
          });
        } else {
          kd.value = 0;
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  List downlineList(String keyword) {
    List list = [];
    for (var i = 0; i < kd.value; i++) {
      list.add([]);
    }
    downlines.forEach((element) {
      if (element["name"].toLowerCase().contains(keyword.trim().toLowerCase()) || element["uplineName"].toLowerCase().contains(keyword.trim().toLowerCase())) {
        list[element["level"] - (level.value + 1)].add(element);
      }
    });

    return list;
  }

  List sortedMemberList(String keyword) {
    List list = [];
    downlines.forEach((element) {
      if (element["type"] == "member" &&
          (element["name"].toLowerCase().contains(keyword.trim().toLowerCase()) ||
              element["uplineName"].toLowerCase().contains(keyword.trim().toLowerCase()))) {
        list.add(element);
      }
    });

    return list;
  }
}
