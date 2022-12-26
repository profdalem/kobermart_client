import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/ppob_pln_postpaid/controllers/ppob_pln_postpaid_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

import '../../../../style.dart';

class PpobPlnPostpaidView extends GetView<PpobPlnPostpaidController> {
  const PpobPlnPostpaidView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "PLN",
            style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          leading: TextButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey.shade800,
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.electric_bolt_rounded,
                  color: Colors.amber.shade700,
                ),
                backgroundColor: Colors.yellow.shade200,
              ),
              title: Text("Token Listrik"),
            ),
          ),
          Card(
            // width: Get.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Nomor meter",
                  style: TextStyle(fontSize: 12),
                ),
                Obx(() => TextField(
                      controller: controller.customerIdC,
                      autofocus: true,
                      autofillHints: [AutofillHints.telephoneNumber],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusColor: Colors.blueGrey.shade50,
                          fillColor: Colors.blueGrey.shade50,
                          filled: true,
                          hintText: "Contoh 123456789",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: controller.fieldError.isNotEmpty ? Colors.red : Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          // isDense: true,
                          contentPadding: EdgeInsets.all(12)),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        controller.customerId.value = value;
                      },
                      onTap: () {},
                    )),
                Obx(() => controller.fieldError.isNotEmpty
                    ? Text(
                        controller.fieldError.value,
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      )
                    : SizedBox()),
                sb15,
                Obx(() => controller.customerId.isEmpty
                    ? Text(
                        "Transaksi terakhir",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    : SizedBox()),
              ]),
            ),
          ),
          sb5,
          Obx(() => controller.customerId.isEmpty
              ? HistoryListView(
                  controller: controller,
                )
              : Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          onPressed: () {
                            controller.plnPostpaidController(context);
                          },
                          child: Container(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Lanjut",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                    )
                  ],
                )))
        ],
      ),
    );
  }
}

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PpobPlnPostpaidController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() => controller.historyList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Tidak ada transaksi"), IconButton(onPressed: () => controller.setHistoryList(), icon: Icon(Icons.refresh))],
              )
            : RefreshIndicator(
                onRefresh: () => controller.setHistoryList(),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: List.generate(
                      controller.historyList.length,
                      (index) => Card(
                              child: ListTile(
                            onTap: () {
                              controller.customerIdC.text = controller.historyList[index]["customerId"];
                              controller.customerId.value = controller.historyList[index]["customerId"];
                              controller.customerIdC.selection = TextSelection.fromPosition(TextPosition(offset: controller.customerIdC.text.length));
                            },
                            title: Text(controller.historyList[index]["customerId"]),
                            subtitle: Text(controller.historyList[index]["name"]),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                          ))),
                ),
              )));
  }
}
