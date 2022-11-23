import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

import '../../../../style.dart';
import '../controllers/ppob_controller.dart';

class PpobView extends GetView<PpobController> {
  PpobView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPOB'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabC,
          tabs: controller.myTabs,
          isScrollable: true,
        ),
      ),
      body: Obx(
        () => controller.isGetDataLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(controller: controller.tabC, children: [
                ListrikView(),
                Center(child: Text("Segera hadir")),
                Center(child: Text("Segera hadir")),
                Center(child: Text("Segera hadir")),
                Center(child: Text("Segera hadir")),
              ]),
      ),
    );
  }
}

class ListrikView extends StatelessWidget {
  ListrikView({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<PpobController>();
  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Card(
            child: CachedNetworkImage(
                imageUrl:
                    "https://cdn.mobilepulsa.net/img/logo/pulsa/small/listrik.png"),
          ),
          sb5,
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PanelTitle(title: "Beli Token & Bayar Listrik")]),
          sb20,
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Saldo anda: "),
                  Text(
                    "Rp ${NumberFormat("#,##0", "id_ID").format(homeC.balance.value)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          sb10,
          Container(
            padding: EdgeInsets.all(16),
            decoration: Shadow1(),
            child: Column(
              children: [
                Text("Pilih produk:"),
                sb10,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.tokenSelected.value = true;
                          // controller.customerId.text = "";
                        },
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                color: controller.tokenSelected.value
                                    ? Colors.amber.shade300
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 8, right: 12, bottom: 8),
                              child: Row(
                                children: [
                                  controller.tokenSelected.value
                                      ? Icon(Icons.check_circle_outline)
                                      : Icon(Icons.circle_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Token Listrik",
                                    style: TextStyle(
                                        fontWeight:
                                            controller.tokenSelected.value
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.tokenSelected.value = false;
                          // controller.customerId.text = "";
                          controller.nominalSelected.value = "";
                        },
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                color: !controller.tokenSelected.value
                                    ? Colors.amber.shade300
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 8, right: 12, bottom: 8),
                              child: Row(
                                children: [
                                  !controller.tokenSelected.value
                                      ? Icon(Icons.check_circle_outline)
                                      : Icon(Icons.circle_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Tagihan Listrik",
                                    style: TextStyle(
                                        fontWeight:
                                            !controller.tokenSelected.value
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb20,
              Container(
                width: Get.width,
                decoration: Shadow1(),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID Pelanggan/No. Meter"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.customerId,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.electric_bolt,
                              color: Colors.amber,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            // isDense: true,
                            contentPadding: EdgeInsets.all(12)),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {},
                        onTap: () {},
                      ),
                      Obx(
                        () => controller.tokenSelected.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sb15,
                                  Text("Nominal token"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 65,
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.dialog(
                                        fit: FlexFit.loose,
                                        showSelectedItems: true,
                                      ),
                                      items: [
                                        "20.000",
                                        "50.000",
                                        "100.000",
                                        "200.000",
                                        "500.000",
                                        "1.000.000",
                                      ],
                                      onChanged: (value) {
                                        controller.nominalSelected.value =
                                            value!
                                                .replaceAll(".", "")
                                                .toString();
                                        controller.pricelistPln
                                            .forEach((element) {
                                          if (controller
                                                  .nominalSelected.value ==
                                              element["nominal"]) {
                                            controller.nominalSelected.value =
                                                element["price"].toString();
                                            controller.codeSelected.value =
                                                element["code"].toString();
                                          }
                                        });
                                      },
                                      selectedItem: "pilih token",
                                    ),
                                  ),
                                  Obx(
                                    () => controller.nominalSelected.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Obx(() => homeC.balance.value <
                                                      int.parse(controller
                                                          .nominalSelected
                                                          .value)
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .amber,
                                                                      style: BorderStyle
                                                                          .solid),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                  ),
                                                                  color: Colors
                                                                      .amber
                                                                      .shade100),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Text(
                                                                "Saldo anda tidak cukup"),
                                                          ),
                                                        ),
                                                        sb10
                                                      ],
                                                    )
                                                  : SizedBox()),
                                              Text("Harga:"),
                                              sb5,
                                              PanelTitle(
                                                  title:
                                                      "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.nominalSelected.value.toString()))}"),
                                            ],
                                          )
                                        : SizedBox(),
                                  ),
                                  sb10
                                ],
                              )
                            : SizedBox(),
                      ),
                      sb10,
                      Obx(
                        () => Container(
                            width: double.infinity,
                            child: controller.tokenSelected.value
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (!controller.isLoading.value) {
                                        controller.setPrepaidInquiryPln();
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: controller.isLoading.value
                                          ? Container(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text("Beli Token"),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!controller.isLoading.value) {
                                        controller.setPostpaidInquiryPln();
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: controller.isLoading.value
                                          ? Container(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text("Cek Tagihan"),
                                    ),
                                  )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          sb20
        ],
      ),
    );
  }
}
