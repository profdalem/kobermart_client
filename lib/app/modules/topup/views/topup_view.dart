import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/data/balance_provider.dart';
import 'package:kobermart_client/app/modules/widgets/sucess.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/topup_controller.dart';

class TopupView extends GetView<TopupController> {
  const TopupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: AppBar(
          title: const Text('Top Up Saldo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [PanelTitle(title: "Tulis nominal Top Up")]),
              sb20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sb15,
                  Container(
                    width: Get.width,
                    decoration: Shadow1(),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Nominal"),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: controller.nominal,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefix: Text("Rp "),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              // isDense: true,
                              contentPadding: EdgeInsets.all(12)),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              controller.jumlah.value = int.parse(controller.nominal.text);
                            } else {
                              controller.jumlah.value = 0;
                            }
                          },
                          onTap: () {
                            controller.nominal.text = "";
                          },
                        ),
                        sb15,
                        Text("Metode"),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(() => DropdownSearch<String>(
                              popupProps: PopupProps.dialog(
                                fit: FlexFit.loose,
                                showSelectedItems: true,
                              ),
                              items: [
                                "cash",
                                "transfer",
                              ],
                              onChanged: (value) {
                                controller.selectedMethod.value = value.toString();
                                print(controller.selectedMethod);
                                print(controller.nominal.text);
                              },
                              selectedItem: controller.selectedMethod.value,
                            )),
                        sb20,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Jumlah"),
                              Obx(() => Text("Rp ${NumberFormat("#,##0", "id_ID").format(controller.jumlah.value)}",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
                      PanelTitle(title: "Ketentuan Topup"),
                      sb10,
                      Text(
                        "1. Nominal minimal Top Up atau tambah saldo adalah Rp100.000,- \n2. Metode yang tersedia adalah cash (COD) dan transfer ke rekening Kobermart.\n3. Jika ingin melakukan pembatalan penarikan harap hubungi admin.",
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
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey))),
              ),
              Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 5,
                child: Obx(() => controller.isLoading.value
                    ? LinearProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          controller.setNewTopUp();
                        },
                        child: Text("Kirim"),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber.shade700)))),
              ),
              Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
