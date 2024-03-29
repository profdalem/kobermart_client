import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

class SuccessTokenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              child: Image.asset("assets/images/bg-elipse-1.png"),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Image.asset("assets/images/bg-elipse-2.png"),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/icon-token.svg",
                  height: Get.width * 0.3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Pembuatan Tokenberhasil!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.07),
                ),
                sb10,
                Text(
                  "Kode Token ${Get.arguments["token"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.06),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: Get.width - 30,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.TRANSACTIONS,
                          arguments: {"refresh": true});
                    },
                    child: PanelTitle(title: "Lihat Transaksi"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade700)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: Get.width - 30,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.HOME);
                    },
                    child: Text(
                      "Beranda",
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
}
