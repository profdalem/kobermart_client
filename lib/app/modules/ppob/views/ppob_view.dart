import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
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
            : Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: TabBarView(controller: controller.tabC, children: [
                      PaketDataView(),
                      PulsaView(),
                      ListrikView(),
                      Center(child: Text("Segera hadir")),
                      Center(child: Text("Segera hadir")),
                    ]),
                  ),
                ],
              ),
      ),
    );
  }
}

class ListrikView extends StatelessWidget {
  ListrikView({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<PpobController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Icon(
            Icons.electric_bolt_rounded,
            color: Colors.amber.shade700,
            size: 30,
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
                    "Rp ${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
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
                                              Obx(() => authC.balance.value < int.parse(controller.nominalSelected.value)
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
  final authC = Get.find<AuthController>();

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
                    "Rp ${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
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
                                      // height: 150,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .getProductList(controller.pricelistPaketData, controller.paketDataOperator.value)
                                            .length,
                                        itemBuilder: (context, index) => Card(
                                          elevation: 2,
                                          child: ListTile(
                                            onTap: () {
                                              onTapProductMethod(
                                                  index,
                                                  controller.getProductList(
                                                      controller.pricelistPaketData, controller.paketDataOperator.value)[index]);
                                            },
                                            title: Text(
                                              controller.getProductList(
                                                      controller.pricelistPaketData, controller.paketDataOperator.value)[index]
                                                  ["product_nominal"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                            ),
                                            // subtitle: Text(
                                            //   controller.getProductList(
                                            //           controller.pricelistPaketData, controller.paketDataOperator.value)[index]
                                            //       ["product_details"],
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                            // ),
                                            trailing: Text(
                                              "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.getProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["sell_price"].toString()))}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => authC.balance.value < int.parse(controller.paketDataNominalSelected.value)
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
                            ],
                          ),
                        ],
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

  void onTapProductMethod(int index, var productData) {
    controller.paketDataCodeSelected.value =
        controller.getProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["product_code"].toString();
    controller.paketDataCodeSelected.refresh();

    controller.paketDataNominalSelected.value =
        controller.getProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["sell_price"].toString();
    controller.paketDataNominalSelected.refresh();

    controller.paketDataNameSelected.value =
        controller.getProductList(controller.pricelistPaketData, controller.paketDataOperator.value)[index]["product_nominal"].toString();

    print(controller.paketDataCodeSelected.value);
    Get.defaultDialog(
        title: "Konfirmasi Pembelian",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
        confirm: ElevatedButton(
            onPressed: () {
              controller.setPrepaidTopupPaketData(productData);
            },
            child: Text("Beli")),
        cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Kembali")));
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

class PulsaView extends StatelessWidget {
  PulsaView({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<PpobController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Icon(
            Icons.phone_android,
            color: Colors.cyan.shade700,
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
                    "Rp ${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
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
                                child: Obx(() => controller.pulsaIcon.value.isNotEmpty
                                    ? Image.asset(
                                        controller.pulsaIcon.value,
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
                          onEditingCompleteMethodPulsa();
                        },
                        onChanged: (value) {
                          onChangedMethodPulsa(value);
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
                          Obx(() => controller.pulsaOperator.isEmpty
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sb15,
                                    Text("Pilih Nominal"),
                                    Column(
                                      children: List.generate(
                                          controller.getProductList(controller.pricelistPulsa, controller.pulsaOperator.value).length,
                                          (index) => GetUtils.isNumericOnly(controller.getProductList(
                                                          controller.pricelistPulsa, controller.pulsaOperator.value)[index]
                                                      ["product_nominal"]) &&
                                                  controller.getProductList(
                                                          controller.pricelistPulsa, controller.pulsaOperator.value)[index]["status"] ==
                                                      "active"
                                              ? Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                                  child: Card(
                                                    elevation: 2,
                                                    child: ListTile(
                                                      onTap: () {
                                                        onTapProductMethodPulsa(index);
                                                      },
                                                      title: Text(
                                                        GetUtils.isNumericOnly(controller.getProductList(
                                                                    controller.pricelistPulsa, controller.pulsaOperator.value)[index]
                                                                ["product_nominal"])
                                                            ? "Pulsa ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.getProductList(controller.pricelistPulsa, controller.pulsaOperator.value)[index]["product_nominal"].toString()))}"
                                                            : controller.getProductList(
                                                                    controller.pricelistPulsa, controller.pulsaOperator.value)[index]
                                                                ["product_nominal"],
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                      ),
                                                      trailing: Text(
                                                        "Rp ${NumberFormat("#,##0", "id_ID").format(controller.getProductList(controller.pricelistPulsa, controller.pulsaOperator.value)[index]["sell_price"])}",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                                                      ),
                                                    ),
                                                  )

                                                  
                                                  )
                                              : SizedBox()),
                                    ),
                                  ],
                                )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => authC.balance.value < int.parse(controller.pulsaNominalSelected.value)
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
                              // Obx(
                              //   () => controller.pulsaNameSelected.isNotEmpty
                              //       ? Column(
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             sb10,
                              //             Text("Paket Pilihan:"),
                              //             PanelTitle(title: controller.pulsaNameSelected.value),
                              //           ],
                              //         )
                              //       : SizedBox(),
                              // ),
                              // Obx(
                              //   () => controller.pulsaOperator.isEmpty
                              //       ? SizedBox()
                              //       : Column(
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             sb10,
                              //             Text("Harga:"),
                              //             PanelTitle(
                              //                 title:
                              //                     "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.pulsaNominalSelected.value.toString()))}"),
                              //           ],
                              //         ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      // sb20,
                      // Container(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       controller.setPrepaidTopupPulsa();
                      //     },
                      //     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       height: 50,
                      //       child: controller.isLoading.value
                      //           ? Container(
                      //               height: 30,
                      //               width: 30,
                      //               child: CircularProgressIndicator(
                      //                 color: Colors.white,
                      //               ),
                      //             )
                      //           : Text("Beli Paket Data"),
                      //     ),
                      //   ),
                      // ),
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

  void onTapProductMethodPulsa(int index) {
    controller.pulsaCodeSelected.value =
        controller.getProductList(controller.pricelistPulsa, controller.pulsaOperator.value)[index]["product_code"].toString();
    controller.pulsaCodeSelected.refresh();

    controller.pulsaNominalSelected.value =
        controller.getProductList(controller.pricelistPulsa, controller.pulsaOperator.value)[index]["sell_price"].toString();
    controller.pulsaNominalSelected.refresh();

    controller.pulsaNameSelected.value =
        controller.getProductList(controller.pricelistPulsa, controller.pulsaOperator.value)[index]["product_nominal"].toString();

    print(controller.pulsaCodeSelected.value);
    Get.defaultDialog(
        title: "Konfirmasi Pembelian",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.pulsaNameSelected.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sb10,
                        Text("Nominal:"),
                        PanelTitle(title: controller.pulsaNameSelected.value),
                      ],
                    )
                  : SizedBox(),
            ),
            Obx(
              () => controller.pulsaOperator.isEmpty
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sb10,
                        Text("Harga:"),
                        PanelTitle(
                            title:
                                "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(controller.pulsaNominalSelected.value.toString()))}"),
                      ],
                    ),
            ),
          ],
        ),
        confirm: ElevatedButton(
            onPressed: () {
              // controller.setPrepaidTopupPaketData(productData);
              controller.setPrepaidTopupPulsa();
            },
            child: Text("Beli")),
        cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Kembali")));
  }

  void onChangedMethodPulsa(String value) {
    if (value.length > 3) {
      controller.getOperator(4, value);
      controller.pulsaNominalSelected.value = "0";
      controller.pulsaCodeSelected.value = "";
      controller.pulsaNameSelected.value = "";
    } else if (value.length > 6) {
      controller.getOperator(6, value);
      controller.pulsaNominalSelected.value = "0";
      controller.pulsaCodeSelected.value = "";
      controller.pulsaNameSelected.value = "";
    } else if (value.isEmpty) {
      controller.pulsaIcon.value = "";
      controller.pulsaOperator.value = "";
      controller.pulsaNominalSelected.value = "0";
      controller.pulsaCodeSelected.value = "";
      controller.pulsaNameSelected.value = "";
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

  void onEditingCompleteMethodPulsa() {
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
      controller.pulsaNominalSelected.value = "0";
      controller.pulsaCodeSelected.value = "";
      controller.pulsaNameSelected.value = "";
    } else if (controller.phoneNumber.text.length > 6) {
      print("length > 6");
      controller.getOperator(6, controller.phoneNumber.text.substring(0, 6));
      controller.pulsaNominalSelected.value = "0";
      controller.pulsaCodeSelected.value = "";
      controller.pulsaNameSelected.value = "";
    } else if (controller.phoneNumber.text.isEmpty) {
      print("length 0");
      controller.pulsaIcon.value = "";
      controller.pulsaOperator.value = "";
      controller.pulsaNominalSelected.value = "0";
      controller.pulsaCodeSelected.value = "";
      controller.pulsaNameSelected.value = "";
    }

    if (controller.phoneNumber.text.length < 2) {
      controller.paketDataPhoneNumberError.value = false;
    }
  }

  // Pulsa method

}
