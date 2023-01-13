import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

import '../../../../style.dart';
import '../controllers/ppob_pln_prepaid_controller.dart';

class PpobPlnPrepaidView extends GetView<PpobPlnPrepaidController> {
  const PpobPlnPrepaidView({Key? key}) : super(key: key);
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
            onPressed: () => Get.offNamed(Routes.DIGITALPRODUCTS),
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
          Container(
            width: Get.width,
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
                    : Text(
                        "Pilih nominal",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )),
              ]),
            ),
          ),
          sb5,
          Obx(() => controller.customerId.isEmpty
              ? HistoryListView(
                  controller: controller,
                )
              : NominalListView(
                  controller: controller,
                ))
        ],
      ),
    );
  }
}

class NominalListView extends StatelessWidget {
  const NominalListView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PpobPlnPrepaidController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () => controller.getPricelist(),
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemCount: controller.productList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            controller.plnPrepaidController(context, index);
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rp" + NumberFormat("#,##0", "id_ID").format(controller.productList[index]["nominal"]),
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    sb10,
                    Text(
                      "Harga",
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                    ),
                    Text(
                      NumberFormat("#,##0", "id_ID").format(controller.productList[index]["sell_price"]),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PpobPlnPrepaidController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() => controller.historyList.isEmpty
            ? Center(child: Text("Tidak ada transaksi"))
            : RefreshIndicator(
              onRefresh: ()=> controller.setHistoryList(),
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
