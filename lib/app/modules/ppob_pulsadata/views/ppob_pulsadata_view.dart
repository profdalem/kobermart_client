import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../style.dart';
import '../controllers/ppob_pulsadata_controller.dart';

class PpobPulsadataView extends GetView<PpobPulsadataController> {
  const PpobPulsadataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String product = Get.arguments["product"];
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Pulsa & Paket Data",
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
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    child: controller.pulsaIcon.isEmpty || controller.paketDataIcon.isEmpty ? Icon(Icons.phone_android) : null,
                    backgroundColor: !controller.pulsaIcon.isEmpty || !controller.paketDataIcon.isEmpty ? Colors.white : null,
                    backgroundImage: controller.isPulsa.value
                        ? (controller.pulsaIcon.isNotEmpty ? AssetImage(controller.pulsaIcon.value) : null)
                        : (controller.paketDataIcon.isNotEmpty ? AssetImage(controller.paketDataIcon.value) : null),
                  ),
                  title: Text(controller.isPulsa.value
                      ? (controller.pulsaOperator.isNotEmpty ? controller.pulsaOperator.value : "Operator")
                      : (controller.paketDataOperator.isNotEmpty ? controller.paketDataOperator.value : "Operator")),
                ),
              )),
          Container(
            width: Get.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Nomor anda",
                  style: TextStyle(fontSize: 12),
                ),
                Obx(() => TextField(
                      controller: controller.phoneNumber,
                      autofocus: true,
                      autofillHints: [AutofillHints.telephoneNumber],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          suffixIcon: Container(child: GestureDetector(onTap: controller.getContact, child: Icon(Icons.contacts, color: Colors.blue.shade700))),
                          focusColor: Colors.blueGrey.shade50,
                          fillColor: Colors.blueGrey.shade50,
                          filled: true,
                          hintText: "Contoh 0819xxx",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(5))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: controller.fieldError.isNotEmpty ? Colors.red : Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          // isDense: true,
                          contentPadding: EdgeInsets.all(12)),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        controller.contactNumber.value = value;
                      },
                      onTap: () {},
                    )),
                Obx(() => controller.fieldError.isNotEmpty
                    ? Text(
                        controller.fieldError.value,
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      )
                    : SizedBox()),
              ]),
            ),
          ),
          Obx(() => controller.contactNumber.value.length >= 4
              ? Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isPulsa.value = true,
                          child: Container(
                              alignment: Alignment.center,
                              color: controller.isPulsa.value ? Colors.blue.shade50 : Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Pulsa",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: controller.isPulsa.value ? Colors.blue : Colors.grey),
                              )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isPulsa.value = false,
                          child: Container(
                              alignment: Alignment.center,
                              color: !controller.isPulsa.value ? Colors.blue.shade50 : Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Paket Data",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: !controller.isPulsa.value ? Colors.blue : Colors.grey),
                              )),
                        ),
                      ),
                    ]),
                  ),
                )
              : SizedBox()),
          sb10,
          Obx(() => controller.contactNumber.value.length >= 4
              ? Expanded(
                  child: controller.isPulsa.value ? PulsaProductView() : DataProductView(),
                )
              : SizedBox()),
        ],
      ),
    );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }
}

class DataProductView extends StatelessWidget {
  DataProductView({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<PpobPulsadataController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : (controller.filteredDataList(controller.listPaketDataWithSellPrice).isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sb20,
                  Text("Produk Kosong"),
                  IconButton(
                      onPressed: () {
                        controller.getPricelist();
                      },
                      icon: Icon(Icons.refresh_rounded))
                ],
              )
            : RefreshIndicator(
                onRefresh: () => Future(() async {
                  controller.isLoading.value = true;
                  await controller.getPricelist();
                }),
                child: ListView(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                  children: List.generate(
                      controller.filteredDataList(controller.listPaketDataWithSellPrice).length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () => controller.paketDataItemController(context, index),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Container(
                                    width: Get.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${index + 1} dari ${controller.filteredDataList(controller.listPaketDataWithSellPrice).length.toString()}",
                                              style: TextStyle(fontSize: 10, color: Colors.grey),
                                            ),
                                            controller.filteredDataList(controller.listPaketDataWithSellPrice)[index]["sell_price"] != null
                                                ? Text(
                                                    "NEW",
                                                    style: TextStyle(color: Colors.green),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                        Text(
                                          controller.filteredDataList(controller.listPaketDataWithSellPrice)[index]["product_nominal"],
                                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: 0.5),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        sb5,
                                        Text(
                                          controller.filteredDataList(controller.listPaketDataWithSellPrice)[index]["product_details"],
                                          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: Colors.grey.shade600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        sb5,
                                        Text(
                                          "Harga",
                                          style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rp" +
                                                  NumberFormat("#,##0", "id_ID").format(
                                                      controller.filteredDataList(controller.listPaketDataWithSellPrice)[index]["sell_price"] != null
                                                          ? controller.listPaketDataWithSellPrice[index]["sell_price"]
                                                          : controller.listPaketDataWithSellPrice[index]["product_price"] + controller.marginData.value),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.5),
                                            ),
                                            GestureDetector(
                                                onTap: () => controller.paketDataItemDetailsController(context, index),
                                                child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Text(
                                                      "Selengkapnya",
                                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                                    )))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              )));
  }
}

class PulsaProductView extends StatelessWidget {
  PulsaProductView({
    Key? key,
  }) : super(key: key);
  final c = Get.find<PpobPulsadataController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemCount: c.listPulsa.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => c.pulsaItemController(context, c.listPulsa[index]),
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
                        NumberFormat("#,##0", "id_ID").format(c.listPulsa[index]),
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                      sb10,
                      Text(
                        "Harga",
                        style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                      ),
                      Text(
                        NumberFormat("#,##0", "id_ID").format(c.listPulsa[index] + c.marginPulsa.value),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
