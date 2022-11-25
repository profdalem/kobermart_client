// ignore_for_file: dead_code, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/data/iakpostpaid_provider.dart';
import 'package:kobermart_client/app/data/iakprepaid_provider.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/style.dart';

class PpobController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Paket Data'),
    const Tab(text: 'Listrik'),
    const Tab(text: 'Pulsa'),
    const Tab(text: 'Internet/Wifi'),
    const Tab(text: 'PDAM'),
  ];

  final homeC = Get.find<HomeController>();

  late TabController tabC;
  late TextEditingController customerId;
  late TextEditingController phoneNumber;

  var isLoading = false.obs;
  var isGetDataLoading = false.obs;
  var isProceedLoading = false.obs;

  // Listrik PLN
  var nominalSelected = "".obs;
  var codeSelected = "".obs;
  var tokenSelected = true.obs;
  var pricelistPln = [].obs;

  // Paket Data
  var paketDataOperator = "".obs;
  var paketDataIcon = "".obs;
  var paketDataNominalSelected = "0".obs;
  var paketDataCodeSelected = "".obs;
  var paketDataNameSelected = "".obs;
  var paketDataPhoneNumberError = false.obs;
  var pricelistPaketData = [].obs;

  @override
  void onInit() async {
    tabC = TabController(
        length: 5, vsync: this, animationDuration: Duration(milliseconds: 300));
    customerId = TextEditingController();
    phoneNumber = TextEditingController();
    if (preFilled) customerId.text = "";
    getProductData();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    customerId.dispose();
    phoneNumber.dispose();
    paketDataOperator.close();
    paketDataIcon.close();
    paketDataNominalSelected.close();
    paketDataCodeSelected.close();
    paketDataNameSelected.close();
    paketDataPhoneNumberError.close();
    pricelistPaketData.close();
    super.onClose();
  }

  String generateRandomString(int len, String code) {
    var r = Random();
    const _chars = 'ABCDEFGHJKMNOPQRSTUVWXYZ1234567890';
    var _time = DateTime.now().year.toString().substring(2, 4) +
        DateTime.now().month.toString() +
        DateTime.now().day.toString();
    return code +
        _time +
        List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  void getProductData() async {
    if (devMode) print("Starting getPlnProduct");
    var timer = new Stopwatch();
    timer.start();
    isGetDataLoading.value = true;

    var update = false;

    final directory = await getApplicationDocumentsDirectory();
    final File productPrepaidPlnFile =
        File('${directory.path}/productPrepaidPln.json');
    final File productPrepaidDataFile =
        File('${directory.path}/productPrepaidData.json');

    if (update) {
      await IakprepaidProvider()
          .getPaketDataPricelist()
          .then((value) => pricelistPaketData.value = value.body);
      productPrepaidDataFile
          .writeAsString(json.encode(pricelistPaketData.value));
      await IakprepaidProvider()
          .getPlnProduct()
          .then((value) => pricelistPln.value = value.body);
      productPrepaidPlnFile.writeAsString(json.encode(pricelistPln.value));
    } else {
      if (await productPrepaidDataFile.exists()) {
        pricelistPaketData.value =
            json.decode(await productPrepaidDataFile.readAsString());
      } else {
        await IakprepaidProvider()
            .getPaketDataPricelist()
            .then((value) => pricelistPaketData.value = value.body);
        productPrepaidDataFile
            .writeAsString(json.encode(pricelistPaketData.value));
      }

      if (await productPrepaidPlnFile.exists()) {
        pricelistPln.value =
            json.decode(await productPrepaidPlnFile.readAsString());
      } else {
        await IakprepaidProvider()
            .getPlnProduct()
            .then((value) => pricelistPln.value = value.body);
        productPrepaidPlnFile.writeAsString(json.encode(pricelistPln.value));
      }
    }

    isGetDataLoading.value = false;
    Get.snackbar("Waktu getPlnProduct:", timer.elapsed.toString(),
        duration: Duration(seconds: 1));
    pricelistPaketData.refresh();
    timer.stop();
    timer.reset();
  }

  void getOperator(int length, String prefix) {
    var op = "";
    // three
    if (length == 4) {
      switch (prefix) {
        case "0896":
          op = "three";
          break;
        case "0897":
          op = "three";
          break;
        case "0898":
          op = "three";
          break;
        case "0899":
          op = "three";
          break;
        case "0895":
          op = "three";
          break;
        // smartfren
        case "0881":
          op = "smartfren";
          break;
        case "0882":
          op = "smartfren";
          break;
        case "0883":
          op = "smartfren";
          break;
        case "0884":
          op = "smartfren";
          break;
        case "0885":
          op = "smartfren";
          break;
        case "0886":
          op = "smartfren";
          break;
        case "0887":
          op = "smartfren";
          break;
        case "0888":
          op = "smartfren";
          break;

        //telkomsel
        case "0812":
          op = "tsel";
          break;
        case "0813":
          op = "tsel";
          break;
        case "0852":
          op = "tsel";
          break;
        case "0853":
          op = "tsel";
          break;
        case "0821":
          op = "tsel";
          break;
        case "0823":
          op = "tsel";
          break;
        case "0822":
          op = "tsel";
          break;
        case "0851":
          op = "tsel";
          break;
        // axis
        case "0838":
          op = "axis";
          break;
        case "0837":
          op = "axis";
          break;
        case "0831":
          op = "axis";
          break;
        case "0832":
          op = "axis";
          break;
        // XL
        case "0817":
          op = "xl";
          break;
        case "0818":
          op = "xl";
          break;
        case "0819":
          op = "xl";
          break;
        case "0859":
          op = "xl";
          break;
        case "0878":
          op = "xl";
          break;
        case "0877":
          op = "xl";
          break;
        // indosat
        case "0814":
          op = "indosat";
          break;
        case "0815":
          op = "indosat";
          break;
        case "0816":
          op = "indosat";
          break;
        case "0855":
          op = "indosat";
          break;
        case "0856":
          op = "indosat";
          break;
        case "0857":
          op = "indosat";
          break;
        case "0858":
          op = "indosat";
          break;
        default:
          op = "unknown";
      }
    } else if (length == 6) {
      switch (prefix) {
        case "085154":
          op = "byu";
          break;
        case "085155":
          op = "byu";
          break;
        case "085156":
          op = "byu";
          break;
        case "085157":
          op = "byu";
          break;
        case "085158":
          op = "byu";
          break;
        default:
      }
    }

    switch (op) {
      case "axis":
        paketDataOperator.value = "Axis Paket Internet";
        paketDataIcon.value = "assets/images/operator/axis.png";
        break;
      case "byu":
        paketDataOperator.value = "axis_paket_internet";
        paketDataIcon.value = "assets/images/operator/byu.png";
        break;
      case "indosat":
        paketDataOperator.value = "Indosat Paket Internet";
        paketDataIcon.value = "assets/images/operator/indosat.png";
        break;
      case "smartfren":
        paketDataOperator.value = "Smartfren Paket Internet";
        paketDataIcon.value = "assets/images/operator/smart.png";
        break;
      case "tsel":
        paketDataOperator.value = "Telkomsel Paket Internet";
        paketDataIcon.value = "assets/images/operator/telkomsel.png";
        break;
      case "three":
        paketDataOperator.value = "Three Paket Internet";
        paketDataIcon.value = "assets/images/operator/three.png";
        break;
      case "xl":
        paketDataOperator.value = "XL Paket Internet";
        paketDataIcon.value = "assets/images/operator/xl.png";
        break;
      default:
    }
  }

  List<dynamic> getPaketDataProductList(List pricelist, String operator) {
    List result = [];
    pricelist.forEach((element) {
      if (element["product_description"] == operator) {
        result.add(element);
      }
    });
    return result;
  }

  void setPostpaidInquiryPln() async {
    if (customerId.text.isEmpty) {
      Get.snackbar(
          "Peringatan", "Kolom ID Pelanggan/No Meter tidak boleh kosong");
    } else {
      if (customerId.text.length < 12) {
        Get.snackbar(
            "Peringatan", "ID Pelanggan/No Meter kurang dari 12 digit");
      } else {
        var refId = generateRandomString(6, "POSPLN");
        isLoading.value = true;
        await IakpostpaidProvider().setInquiryPlnA(customerId.text, refId).then(
          (value) {
            isLoading.value = false;
            if (value.body["code"] == 400) {
              Get.defaultDialog(
                  title: value.body["status"],
                  content: Text(value.body["data"]["message"]));
            } else {
              var data = value.body;

              Get.toNamed(Routes.TRXDETAIL_POSTPAID,
                  arguments: {"data": data, "createdAt": Timestamp.now()});
              // Get.defaultDialog(
              //   title: "Rincian Tagihan",
              //   content: Padding(
              //     padding: const EdgeInsets.only(left: 15, right: 15),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Text("Nama rekening:"),
              //         Text(data["tr_name"],
              //             style: TextStyle(fontWeight: FontWeight.bold)),
              //         sb10,
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text("No Meter:"),
              //                 Text(data["hp"],
              //                     style:
              //                         TextStyle(fontWeight: FontWeight.bold)),
              //                 sb5,
              //                 Text("Denda:"),
              //                 Text(
              //                     "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(data["desc"]["tagihan"]["detail"][0]["denda"].toString()))}",
              //                     style:
              //                         TextStyle(fontWeight: FontWeight.bold)),
              //               ],
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: [
              //                 Text("Periode:"),
              //                 Text(
              //                   DateFormat.yMMMM('id_ID').format(DateTime(
              //                       int.parse(data["period"]
              //                           .toString()
              //                           .substring(0, 4)),
              //                       int.parse(data["period"]
              //                           .toString()
              //                           .substring(5, 6)))),
              //                   style: TextStyle(fontWeight: FontWeight.bold),
              //                 ),
              //                 sb5,
              //                 Text("Biaya Admin:"),
              //                 Text(
              //                     "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(data["admin"].toString()))}",
              //                     style:
              //                         TextStyle(fontWeight: FontWeight.bold)),
              //               ],
              //             )
              //           ],
              //         ),
              //         sb5,
              //         Text("Total Biaya"),
              //         Text(
              //             "Rp ${NumberFormat("#,##0", "id_ID").format(data["price"])}",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 20)),
              //         sb5,
              //       ],
              //     ),
              //   ),
              // );
            }
          },
        );
      }
    }
  }

  void setPrepaidInquiryPln() async {
    if (customerId.text.isEmpty) {
      Get.snackbar(
          "Peringatan", "Kolom ID Pelanggan/No Meter tidak boleh kosong");
    } else {
      if (customerId.text.length < 11) {
        Get.snackbar(
            "Peringatan", "ID Pelanggan/No Meter kurang dari 11 digit");
      } else {
        if (nominalSelected.isEmpty) {
          Get.snackbar("Peringatan", "Pilih nominal token terlebih dahulu");
        } else {
          isLoading.value = true;
          await IakprepaidProvider()
              .setInquiryPln(customerId.text)
              .then((value) {
            var response = value.body;

            if (response["status"] == "failed") {
              Get.defaultDialog(
                title: "Pembelian Gagal",
                content: Align(
                  alignment: Alignment.center,
                  child: Text("Pastikan nomor meter anda benar"),
                ),
              );
            } else {
              Get.defaultDialog(
                title: "Rincian Transaksi",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jenis Layanan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Token Listrik ${NumberFormat("#,##0", "id_ID").format(int.parse(nominalSelected.value.toString()))}"),
                    sb5,
                    Text(
                      "Nomor",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(response["data"]["meter_no"]),
                    sb5,
                    Text(
                      "Nama",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(response["data"]["name"]),
                    sb5,
                    Text(
                      "Tarif/Daya",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(response["data"]["segment_power"]),
                    sb5,
                    Text(
                      "Harga",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(nominalSelected.value.toString()))}"),
                  ],
                ),
                radius: 15,
                confirm: Obx(
                  () => isProceedLoading.value
                      ? Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            isProceedLoading.value = true;
                            if (await HomeController().getBalance() <
                                int.parse(nominalSelected.value)) {
                              isProceedLoading.value = false;
                              Get.defaultDialog(
                                  title: "Saldo tidak cukup",
                                  content: Text(
                                      "Pastikan saldo anda cukup sebelum melakukan transaksi"));
                            } else {
                              var refId = generateRandomString(6, "PREPLN");
                              await IakprepaidProvider()
                                  .setTopUp(
                                      customerId.text,
                                      refId,
                                      codeSelected.value,
                                      nominalSelected.value,
                                      response["data"])
                                  .then((value) {
                                if (value.statusCode != 400) {
                                  nominalSelected.value = "";
                                  codeSelected.value = "";
                                  // Get.offNamed(Routes.TRANSACTIONS,
                                  //     arguments: {"refresh": true});
                                  Get.offNamed(Routes.TRXDETAIL_PREPAID,
                                      arguments: {"data": value.body});
                                } else {
                                  nominalSelected.value = "";
                                  codeSelected.value = "";
                                  Get.defaultDialog(
                                      title: "Gagal",
                                      content: Text(
                                          "Terjadi kesalahan, mohon ulangi transaksi kembali"));
                                }
                              });
                              homeC.balance.value = await homeC.getBalance();
                              isProceedLoading.value = false;
                            }
                          },
                          child: Text("Bayar"),
                        ),
                ),
                cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Batal"),
                ),
              );
            }
            isLoading.value = false;
          });
        }
      }
    }
  }
}
