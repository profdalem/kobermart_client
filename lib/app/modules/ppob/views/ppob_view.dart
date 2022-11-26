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
                PaketDataView(),
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
            child: CachedNetworkImage(imageUrl: "https://cdn.mobilepulsa.net/img/logo/pulsa/small/listrik.png"),
          ),
          sb5,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [PanelTitle(title: "Beli Token & Bayar Listrik")]),
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
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  GestureDetector(
                    onTap: () {
                      controller.tokenSelected.value = true;
                      // controller.customerId.text = "";
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: controller.tokenSelected.value ? Colors.amber.shade300 : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
                          child: Row(
                            children: [
                              controller.tokenSelected.value ? Icon(Icons.check_circle_outline) : Icon(Icons.circle_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Token Listrik",
                                style: TextStyle(fontWeight: controller.tokenSelected.value ? FontWeight.bold : FontWeight.normal),
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
                            color: !controller.tokenSelected.value ? Colors.amber.shade300 : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
                          child: Row(
                            children: [
                              !controller.tokenSelected.value ? Icon(Icons.check_circle_outline) : Icon(Icons.circle_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Tagihan Listrik",
                                style: TextStyle(fontWeight: !controller.tokenSelected.value ? FontWeight.bold : FontWeight.normal),
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
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
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
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            // isDense: true,
                            contentPadding: EdgeInsets.all(12)),
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                                        controller.nominalSelected.value = value!.replaceAll(".", "").toString();
                                        controller.pricelistPln.forEach((element) {
                                          if (controller.nominalSelected.value == element["nominal"]) {
                                            controller.nominalSelected.value = element["price"].toString();
                                            controller.codeSelected.value = element["code"].toString();
                                          }
                                        });
                                      },
                                      selectedItem: "pilih token",
                                    ),
                                  ),
                                  Obx(
                                    () => controller.nominalSelected.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Obx(() => homeC.balance.value < int.parse(controller.nominalSelected.value)
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          alignment: Alignment.center,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.amber, style: BorderStyle.solid),
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(5),
                                                              ),
                                                              color: Colors.amber.shade100),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Text("Saldo anda tidak cukup"),
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

class PaketDataView extends StatelessWidget {
  PaketDataView({
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
          Icon(
            Icons.cell_wifi_rounded,
            color: Colors.blue,
            size: 30,
          ),
          sb5,
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [PanelTitle(title: "Beli Paket Data")]),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb20,
              Container(
                width: Get.width,
                decoration: Shadow1(),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nomor handphone"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.phoneNumber,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffixIcon: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Obx(() => controller.paketDataIcon.value.isNotEmpty
                                    ? Image.asset(
                                        controller.paketDataIcon.value,
                                        fit: BoxFit.contain,
                                      )
                                    : SizedBox()),
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints.expand(width: 50, height: 35),
                            isDense: true,
                            hintText: "08xx xxxx xxxx",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            // isDense: true,
                            contentPadding: EdgeInsets.all(10)),
                        textAlignVertical: TextAlignVertical.center,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        onEditingComplete: () {
                          onEditingCompleteMethod();
                        },
                        onChanged: (value) {
                          onChangedMethod(value);
                        },
                      ),
                      Obx(() => controller.paketDataPhoneNumberError.value
                          ? Text(
                              "*Penulisan nomor harus diawali '08'",
                              style: TextStyle(color: Colors.red.shade600),
                            )
                          : SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => controller.paketDataOperator.isEmpty
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sb15,
                                    Text("Pilih Paket Data"),
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      child: ListView(
                                        children: List.generate(
                                            controller
                                                .getPaketDataProductList(controller.pricelistPaketData, controller.paketDataOperator.value)
                                                .length,
                                            (index) => Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      onTapProductMethod(index);
                                                    },
                                                    child: Card(
                                                      margin: EdgeInsets.only(right: 10),
                                                      color: controller.paketDataCodeSelected.value ==
                                                              controller
                                                                  .getPaketDataProductList(controller.pricelistPaketData,
                                                                      controller.paketDataOperator.value)[index]["product_code"]
                                                                  .toString()
                                                          ? Colors.blue.shade100
                                                          : Colors.white,
                                                      elevation: 2,
                                                      child: Container(
                                                        padding: EdgeInsets.all(10),
                                                        width: Get.width * 0.4,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  controller.getPaketDataProductList(
                                                                          controller.pricelistPaketData, controller.paketDataOperator.value)[index]
                                                                      ["product_description"],
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 8),
                                                                ),
                                                                Text(
                                                                  controller.getPaketDataProductList(
                                                                          controller.pricelistPaketData, controller.paketDataOperator.value)[index]
                                                                      ["product_nominal"],
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                                ),
                                                                Text(
                                                                  controller.getPaketDataProductList(
                                                                          controller.pricelistPaketData, controller.paketDataOperator.value)[index]
                                                                      ["product_details"],
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontSize: 10),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "Rp ${NumberFormat("#,##0", "id_ID").format(controller.getPaketDataProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["sell_price"])}",
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                                                                ),
                                                                Text(
                                                                  "Masa aktif: ${controller.getPaketDataProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["active_period"]} hari",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontSize: 10),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => homeC.balance.value < int.parse(controller.paketDataNominalSelected.value)
                                  ? Column(
                                      children: [
                                        sb10,
                                        Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.amber, style: BorderStyle.solid),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color: Colors.amber.shade100),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text("Saldo anda tidak cukup"),
                                          ),
                                        ),
                                        sb10
                                      ],
                                    )
                                  : SizedBox()),
                              Obx(
                                () => controller.paketDataNameSelected.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          sb10,
                                          Text("Paket Pilihan:"),
                                          PanelTitle(title: controller.paketDataNameSelected.value),
                                        ],
                                      )
                                    : SizedBox(),
                              ),
                              Obx(
                                () => controller.paketDataOperator.isEmpty
                                    ? SizedBox()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          sb10,
                                          Text("Harga:"),
                                          PanelTitle(
                                              title:
                                                  "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.paketDataNominalSelected.value.toString()))}"),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sb20,
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.setPrepaidTopupPaketData();
                          },
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
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
                                : Text("Beli Paket Data"),
                          ),
                        ),
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

  void onTapProductMethod(int index) {
    controller.paketDataCodeSelected.value =
        controller.getPaketDataProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["product_code"].toString();
    controller.paketDataCodeSelected.refresh();

    controller.paketDataNominalSelected.value =
        controller.getPaketDataProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["sell_price"].toString();
    controller.paketDataNominalSelected.refresh();

    controller.paketDataNameSelected.value =
        controller.getPaketDataProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["product_nominal"].toString();

    print(controller.paketDataCodeSelected.value);
  }

  void onChangedMethod(String value) {
    if (value.length > 3) {
      controller.getOperator(4, value);
      controller.paketDataNominalSelected.value = "0";
      controller.paketDataCodeSelected.value = "";
      controller.paketDataNameSelected.value = "";
    } else if (value.length > 6) {
      controller.getOperator(6, value);
      controller.paketDataNominalSelected.value = "0";
      controller.paketDataCodeSelected.value = "";
      controller.paketDataNameSelected.value = "";
    } else if (value.isEmpty) {
      controller.paketDataIcon.value = "";
      controller.paketDataOperator.value = "";
      controller.paketDataNominalSelected.value = "0";
      controller.paketDataCodeSelected.value = "";
      controller.paketDataNameSelected.value = "";
    }

    if (value.length > 1) {
      if (value.substring(0, 2) != "08" && value.length > 1) {
        controller.paketDataPhoneNumberError.value = true;
      } else {
        controller.paketDataPhoneNumberError.value = false;
      }
    }
    if (value.length < 2) {
      controller.paketDataPhoneNumberError.value = false;
    }
  }

  void onEditingCompleteMethod() {
    FocusManager.instance.primaryFocus?.unfocus();
    print(controller.phoneNumber.text);
    if (controller.phoneNumber.text.length > 3) {
      print("length > 3");
      if (controller.phoneNumber.text.substring(0, 2) != "08" && controller.phoneNumber.text.length > 1) {
        controller.paketDataPhoneNumberError.value = true;
      } else {
        controller.paketDataPhoneNumberError.value = false;
      }
      controller.getOperator(4, controller.phoneNumber.text.substring(0, 4));
      controller.paketDataNominalSelected.value = "0";
      controller.paketDataCodeSelected.value = "";
      controller.paketDataNameSelected.value = "";
    } else if (controller.phoneNumber.text.length > 6) {
      print("length > 6");
      controller.getOperator(6, controller.phoneNumber.text.substring(0, 6));
      controller.paketDataNominalSelected.value = "0";
      controller.paketDataCodeSelected.value = "";
      controller.paketDataNameSelected.value = "";
    } else if (controller.phoneNumber.text.isEmpty) {
      print("length 0");
      controller.paketDataIcon.value = "";
      controller.paketDataOperator.value = "";
      controller.paketDataNominalSelected.value = "0";
      controller.paketDataCodeSelected.value = "";
      controller.paketDataNameSelected.value = "";
    }

    if (controller.phoneNumber.text.length < 2) {
      controller.paketDataPhoneNumberError.value = false;
    }
  }
}
