import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/modules/widgets/sucess_transfer.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/transfernominal_controller.dart';

class TransfernominalView extends GetView<TransfernominalController> {
  const TransfernominalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transfer Dana'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [PanelTitle(title: "Tulis nominal Transfer")]),
              sb20,
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: PanelTitle(title: "Tujuan"),
                ),
              ),
              sb10,
              Container(
                decoration: Shadow1(),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          "https://i.pravatar.cc/150?img=1")),
                  title: PanelTitle(title: "Margot Robbie"),
                  subtitle: Text("Upline: Kennedy Monroe"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sb20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PanelTitle(title: "Detail Transfer"),
                        Row(
                          children: [
                            Text("Saldo anda: "),
                            Text(
                              "Rp 2.000.000",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  sb10,
                  Container(
                    width: Get.width,
                    decoration: Shadow1(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: 15, bottom: 15, right: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nominal transfer"),
                            SizedBox(
                              height: 5,
                            ),
                            Obx(() => TextField(
                                  controller: controller.nominal,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefix: Text("Rp "),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.jumlah.value >
                                                    controller.saldo.value
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      // isDense: true,
                                      contentPadding: EdgeInsets.all(12)),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      controller.jumlah.value =
                                          int.parse(controller.nominal.text);
                                    } else {
                                      controller.jumlah.value = 0;
                                    }
                                  },
                                  onTap: () {
                                    controller.nominal.text = "";
                                  },
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Obx(() {
                              if (controller.jumlah.value >
                                  controller.saldo.value) {
                                return Column(
                                  children: [
                                    Text(
                                      "Saldo anda tidak cukup!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                            Row(
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text("biaya Rp1000"),
                              ],
                            ),
                            sb20,
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Jumlah"),
                                  Obx(() => Text(
                                      "Rp ${NumberFormat("#,##0", "id_ID").format(controller.jumlah.value)}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                                ],
                              ),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            color: Colors.white,
            height: Get.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Kembali"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey))),
                ),
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 5,
                  child: Obx(() => ElevatedButton(
                      onPressed: () {
                        controller.jumlah.value > controller.saldo.value ||
                                controller.jumlah < 10000
                            ? print("")
                            : Get.off(
                                () => SuccessTransferPage(),
                              );

                        controller.jumlah < 10000
                            ? Get.defaultDialog(
                                title: "Nominal kurang",
                                content:
                                    Text("Jumlah transfer minimal Rp10.000"),
                                cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Tutup")))
                            : print("");
                      },
                      child: Text("Kirim"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              controller.jumlah.value >
                                          controller.saldo.value ||
                                      controller.jumlah < 10000
                                  ? Colors.grey
                                  : Colors.amber.shade700)))),
                ),
                Expanded(flex: 2, child: SizedBox()),
              ],
            )),
      ),
    );
  }
}
