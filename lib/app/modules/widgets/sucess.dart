import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/modules/home/views/home_view.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Get.arguments[0]);
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
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: Get.width * 0.3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Permintaan Top Up sebesar Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(Get.arguments[0]))} berhasil!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.08),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: Get.width - 30,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
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
