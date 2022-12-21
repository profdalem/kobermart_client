import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/qrcode_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeView extends GetView<QrcodeController> {
  const QrcodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code Anda'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Obx(() => QrImage(
                    data: controller.qrcode.value,
                    version: QrVersions.auto,
                    size: Get.width * 0.7,
                  )),
              sb15,
              Text(
                'QR Code Validation',
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                  onPressed: () {
                    controller.generateCodes();
                  },
                  child: Icon(Icons.refresh))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: Get.height * 0.08,
          decoration: Shadow1(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.5,
                child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.HOME);
                    },
                    child: Text("Ke Beranda"),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
