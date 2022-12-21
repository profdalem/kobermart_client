import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/style.dart';

class NoInternetPage extends StatelessWidget {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var icon = Icons.network_locked;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue.shade400,
        body: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Icon(
                    setIcon(authC.connectionStatus.value),
                    color: Colors.white,
                    size: Get.width * 0.1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Internet Terputus",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: Get.width * 0.07),
                ),
                sb10,
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: Get.width - 30,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      InternetAddress.lookup("google.com").then((value) {
                        print("internet nyala");
                      }).catchError((onError) {
                        print("internet mati");
                      });
                    },
                    child: Text(
                      "Coba lagi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  IconData setIcon(ConnectivityResult con) {
    var icon;
    switch (authC.connectionStatus.value) {
      case ConnectivityResult.none:
        icon = Icons.signal_cellular_null_outlined;
        break;
      case ConnectivityResult.wifi:
        icon = Icons.signal_wifi_connected_no_internet_4_outlined;
        break;
      case ConnectivityResult.mobile:
        icon = Icons.signal_cellular_nodata_outlined;
        break;
      default:
    }
    return icon;
  }
}
