import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/modules/widgets/sucess_withdrawal.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/withdrawal_controller.dart';

class WithdrawalView extends GetView<WithdrawalController> {
  WithdrawalView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Penarikan Dana'),
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
                  children: [PanelTitle(title: "Tulis nominal penarikan")]),
              sb20,
              Container(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Saldo anda: "),
                    Text(
                      "Rp ${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              sb10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sb15,
                  Container(
                    width: Get.width,
                    decoration: Shadow1(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: 15, bottom: 15, right: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nominal"),
                            SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () {
                                return TextField(
                                  controller: controller.nominal,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: controller.jumlah.value >
                                                    controller.saldo.value
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      prefix: Text("Rp "),
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
                                );
                              },
                            ),
                            sb10,
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
                            sb15,
                            Text("Metode"),
                            SizedBox(
                              height: 5,
                            ),
                            DropdownSearch<String>(
                              popupProps: PopupProps.dialog(
                                fit: FlexFit.loose,
                                showSelectedItems: true,
                              ),
                              items: [
                                "Cash",
                                "Transfer",
                              ],
                              onChanged: (value) {
                                print(value);
                              },
                              selectedItem: "Cash",
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
              sb15,
              Container(
                width: double.infinity,
                decoration: Shadow1(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PanelTitle(title: "Ketentuan Penarikan"),
                      sb10,
                      Text(
                        "1. Permintaan withdraw atau penarikan hanya berlaku pada tanggal 1 s/d 20 setiap bulannya. \n2. Dana akan ditransfer/diantarkan pada anggota pada tanggal 25 (jika tidak libur) setiap bulannya.\n3. Jika ingin melakukan pembatalan penarikan harap hubungi admin.",
                        style: TextStyle(wordSpacing: 1, height: 1.2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("hubungi admin");
                        },
                        child: Text(
                          'Hubungi admin',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              )
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
                      child: Text("Batal"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey))),
                ),
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 5,
                  child: Obx(() => ElevatedButton(
                      onPressed: () {
                        var requirement = 0;
                        controller.jumlah.value > controller.saldo.value
                            ? Get.defaultDialog(
                                title: "Saldo Kurang",
                                content: Text("Nominal harus sesuai saldo"),
                                cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Tutup")))
                            : requirement++;

                        controller.jumlah.value < 100000
                            ? Get.defaultDialog(
                                title: "Nominal Kurang",
                                content: Text("Minimal penarikan Rp100.000"),
                                cancel: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Tutup")))
                            : requirement++;

                        if (requirement > 1) {
                          Get.off(
                            () => SuccessWithdrawalPage(),
                          );
                        }
                      },
                      child: Text("Kirim"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              controller.jumlah.value >
                                          controller.saldo.value ||
                                      controller.jumlah.value < 100000
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
