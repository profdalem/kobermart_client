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
          title: const Text('QR Code'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Obx(() => Center(
                child: Stack(alignment: AlignmentDirectional.center,
                  children: [
                  if(controller.qrcode.value.isNotEmpty) QrImage(
                      data: controller.qrcode.value,
                      version: QrVersions.auto,
                      size: Get.width * 0.7, foregroundColor: controller.remaining.value > 0? Colors.black :Colors.grey.shade400,
                    ),
                  if(controller.remaining.value <= 0) Center(child: GestureDetector(
                    onTap: () => controller.generateCodes(),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red.shade300, borderRadius: BorderRadius.circular(10)),
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Muat ulang"), SizedBox(width: 5,),
                            Icon(Icons.refresh),
                          ],
                        ),
                      )),
                  )),
                ],),
              )),
              
              Obx(()=> controller.remaining.value > 0? Column(
                children: [
                  sb15,
              Text(
                "Sisa waktu: ",
                style: TextStyle(fontSize: 16),
              ),
                  Text(
                     controller.remaining.value.toString()+" detik",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ): SizedBox()),
              sb15,
              
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
