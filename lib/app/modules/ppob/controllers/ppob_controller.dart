// ignore_for_file: dead_code, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:get_cli/common/utils/json_serialize/json_ast/utils/grapheme_splitter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/firebase.dart';
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

class PpobController extends GetxController with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Paket Data'),
    const Tab(text: 'Pulsa'),
    const Tab(text: 'Listrik'),
    const Tab(text: 'Internet/Wifi'),
    const Tab(text: 'PDAM'),
  ];

  final box = GetStorage();
  final authC = Get.find<AuthController>();

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
  var paketDataNameSelected = "".obs;
  var paketDataCodeSelected = "".obs;
  var paketDataNominalSelected = "0".obs;
  var paketDataOperator = "".obs;
  var paketDataIcon = "".obs;
  var paketDataPhoneNumberError = false.obs;
  var pricelistPaketData = [].obs;

  // Pulsa
  var pulsaNameSelected = "".obs;
  var pulsaCodeSelected = "".obs;
  var pulsaNominalSelected = "0".obs;
  var pulsaOperator = "".obs;
  var pulsaIcon = "".obs;
  var pricelistPulsa = [].obs;

  @override
  void onInit() async {
    tabC = TabController(length: 5, vsync: this, animationDuration: Duration(milliseconds: 300));
    customerId = TextEditingController();
    phoneNumber = TextEditingController();
    if (preFilled) customerId.text = "530000000002";
    if (preFilled) phoneNumber.text = "085313924122";
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
    var _time = DateTime.now().year.toString().substring(2, 4) + DateTime.now().month.toString() + DateTime.now().day.toString();
    return code + _time + List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  void getProductData() async {
    var timer = new Stopwatch();
    timer.start();
    isGetDataLoading.value = true;

    final directory = await getApplicationDocumentsDirectory();
    final File productPrepaidPlnFile = File('${directory.path}/productPrepaidPln.json');
    final File productPrepaidDataFile = File('${directory.path}/productPrepaidData.json');
    final File productPrepaidPulsaFile = File('${directory.path}/productPrepaidPulsa.json');

    // get lastupdate data from database
    final paketDataLastUpdate = (await UpdateRef.doc("paketdata").get().then((value) {
      if (devMode) print((value.data()!["lastUpdate"] as Timestamp).toDate());
      return value;
    }))
        .data()!["lastUpdate"] as Timestamp;
    final milliseconds = paketDataLastUpdate.millisecondsSinceEpoch;

    // box.remove("paketDataLastUpdate");
    if (box.read("paketDataLastUpdate") == null) {
      //write it on the device so it can be used to compare
      box.write("paketDataLastUpdate", milliseconds);
      // print(box.read("paketDataLastUpdate"));
      // Get first batch of data

      print("start get sellpricess from firebase");
      List prepaidPricelist = await IakprepaidProvider().getPrepaidPricelist("", "").then((value) {
        print("get prepaid Pricelist done");
        return value.body["data"]["pricelist"] as List;
      });

      print("start get sellpricess from firebase");
      var sellPrices = await Prepaid.get().then((value) {
        print("get sellprices done");
        return value;
      }).catchError((err) {
        print(err);
        Get.snackbar("ERROR", err.toString());
      });

      isGetDataLoading.value = false;

      print("start get paketdata");
      // await IakprepaidProvider().getPaketDataPricelist().then((value) => pricelistPaketData.value = value.body);
      // await IakprepaidProvider().getPrepaidPricelist("data", "").then((value) async {
      //   var temp = value.body["data"]["pricelist"] as List;
      //   for (var i = 0; i < temp.length; i++) {
      //     var productPriceData = sellPrices.docs.firstWhereOrNull((element) => element.id == temp[i]["product_code"]);
      //     if (productPriceData == null) {
      //       temp[i]["sell_price"] = temp[i]["product_price"] + 2000;
      //       temp[i]["margin"] = 2000;
      //     } else {
      //       temp[i]["sell_price"] = productPriceData.data()["sell_price"];
      //       temp[i]["margin"] = productPriceData.data()["margin"];
      //     }
      //   }
      //   pricelistPaketData.value = temp;
      // });
      {
        var temp = prepaidPricelist.where((element) => element["product_type"] == "data").toList();
        for (var i = 0; i < temp.length; i++) {
          var productPriceData = sellPrices.docs.firstWhereOrNull((element) => element.id == temp[i]["product_code"]);
          if (productPriceData == null) {
            temp[i]["sell_price"] = temp[i]["product_price"] + 2000;
            temp[i]["margin"] = 2000;
          } else {
            temp[i]["sell_price"] = productPriceData.data()["sell_price"];
            temp[i]["margin"] = productPriceData.data()["margin"];
          }
        }
        pricelistPaketData.value = temp;
      }
      productPrepaidDataFile.writeAsString(json.encode(pricelistPaketData.value));

      print("start get pulsa");
      // await IakprepaidProvider().getPulsaPricelist().then((value) => pricelistPulsa.value = value.body);
      // await IakprepaidProvider().getPrepaidPricelist("pulsa", "").then((value) async {
      //   var temp = value.body["data"]["pricelist"] as List;
      //   for (var i = 0; i < temp.length; i++) {
      //     var productPriceData = sellPrices.docs.firstWhereOrNull((element) => element.id == temp[i]["product_code"]);
      //     if (productPriceData == null) {
      //       temp[i]["sell_price"] = temp[i]["product_price"] + 2000;
      //       temp[i]["margin"] = 2000;
      //     } else {
      //       temp[i]["sell_price"] = productPriceData.data()["sell_price"];
      //       temp[i]["margin"] = productPriceData.data()["margin"];
      //     }
      //   }
      //   pricelistPulsa.value = temp;
      // });
      {
        var temp = prepaidPricelist.where((element) => element["product_type"] == "pulsa").toList();
        for (var i = 0; i < temp.length; i++) {
          var productPriceData = sellPrices.docs.firstWhereOrNull((element) => element.id == temp[i]["product_code"]);
          if (productPriceData == null) {
            temp[i]["sell_price"] = temp[i]["product_price"] + 2000;
            temp[i]["margin"] = 2000;
          } else {
            temp[i]["sell_price"] = productPriceData.data()["sell_price"];
            temp[i]["margin"] = productPriceData.data()["margin"];
          }
        }
        pricelistPulsa.value = temp;
      }
      productPrepaidPulsaFile.writeAsString(json.encode(pricelistPulsa.value));

      print("start get pln");
      // await IakprepaidProvider().getPlnProduct().then((value) => pricelistPln.value = value.body);
      // await IakprepaidProvider().getPrepaidPricelist("pln", "").then((value) async {
      //   var temp = value.body["data"]["pricelist"] as List;
      //   for (var i = 0; i < temp.length; i++) {
      //     var productPriceData = sellPrices.docs.firstWhereOrNull((element) => element.id == temp[i]["product_code"]);
      //     if (productPriceData == null) {
      //       temp[i]["sell_price"] = temp[i]["product_price"] + 2000;
      //       temp[i]["margin"] = 2000;
      //     } else {
      //       temp[i]["sell_price"] = productPriceData.data()["sell_price"];
      //       temp[i]["margin"] = productPriceData.data()["margin"];
      //     }
      //   }
      //   pricelistPln.value = temp;
      // });
      {
        var temp = prepaidPricelist.where((element) => element["product_type"] == "pln").toList();
        for (var i = 0; i < temp.length; i++) {
          var productPriceData = sellPrices.docs.firstWhereOrNull((element) => element.id == temp[i]["product_code"]);
          if (productPriceData == null) {
            temp[i]["sell_price"] = temp[i]["product_price"] + 2000;
            temp[i]["margin"] = 2000;
          } else {
            temp[i]["sell_price"] = productPriceData.data()["sell_price"];
            temp[i]["margin"] = productPriceData.data()["margin"];
          }
        }
        pricelistPln.value = temp;
      }
      productPrepaidPlnFile.writeAsString(json.encode(pricelistPln.value));
    } else {
      if (milliseconds > box.read("paketDataLastUpdate")) {
        if (devMode) print("data is old");

        await IakprepaidProvider().getPaketDataPricelist().then((value) => pricelistPaketData.value = value.body);
        productPrepaidDataFile.writeAsString(json.encode(pricelistPaketData.value));

        await IakprepaidProvider().getPulsaPricelist().then((value) => pricelistPulsa.value = value.body);
        productPrepaidPulsaFile.writeAsString(json.encode(pricelistPulsa.value));

        await IakprepaidProvider().getPlnProduct().then((value) => pricelistPln.value = value.body);
        productPrepaidPlnFile.writeAsString(json.encode(pricelistPln.value));

        box.write("paketDataLastUpdate", milliseconds);
      } else {
        if (devMode) print("data is the newest");

        if (await productPrepaidDataFile.exists()) {
          pricelistPaketData.value = json.decode(await productPrepaidDataFile.readAsString());
        } else {
          if (devMode) print("Load PaketData data from server");
          await IakprepaidProvider().getPaketDataPricelist().then((value) => pricelistPaketData.value = value.body);
          productPrepaidDataFile.writeAsString(json.encode(pricelistPaketData.value));
        }

        if (await productPrepaidPulsaFile.exists()) {
          pricelistPulsa.value = json.decode(await productPrepaidPulsaFile.readAsString());
        } else {
          if (devMode) print("Load Pulsa data from server");
          await IakprepaidProvider().getPulsaPricelist().then((value) => pricelistPulsa.value = value.body);
          productPrepaidPulsaFile.writeAsString(json.encode(pricelistPulsa.value));
        }

        if (await productPrepaidPlnFile.exists()) {
          pricelistPln.value = json.decode(await productPrepaidPlnFile.readAsString());
        } else {
          if (devMode) print("Load Pln data from server");
          await IakprepaidProvider().getPlnProduct().then((value) => pricelistPln.value = value.body);
          productPrepaidPlnFile.writeAsString(json.encode(pricelistPln.value));
        }
      }
    }

    isGetDataLoading.value = false;
    pricelistPaketData.refresh();
    pricelistPln.refresh();
    pricelistPulsa.refresh();

    if (devMode) Get.snackbar("Waktu getPPOB Products:", timer.elapsed.toString(), duration: Duration(seconds: 1));
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
        pulsaOperator.value = "AXIS";
        paketDataIcon.value = "assets/images/operator/axis.png";
        pulsaIcon.value = "assets/images/operator/axis.png";
        break;
      case "byu":
        paketDataOperator.value = "axis_paket_internet";
        pulsaOperator.value = "By.U";
        paketDataIcon.value = "assets/images/operator/byu.png";
        pulsaIcon.value = "assets/images/operator/byu.png";
        break;
      case "indosat":
        paketDataOperator.value = "Indosat Paket Internet";
        pulsaOperator.value = "Indosat";
        paketDataIcon.value = "assets/images/operator/indosat.png";
        pulsaIcon.value = "assets/images/operator/indosat.png";
        break;
      case "smartfren":
        paketDataOperator.value = "Smartfren Paket Internet";
        pulsaOperator.value = "Smart";
        paketDataIcon.value = "assets/images/operator/smart.png";
        pulsaIcon.value = "assets/images/operator/smart.png";
        break;
      case "tsel":
        paketDataOperator.value = "Telkomsel Paket Internet";
        pulsaOperator.value = "Telkomsel";
        paketDataIcon.value = "assets/images/operator/telkomsel.png";
        pulsaIcon.value = "assets/images/operator/telkomsel.png";
        break;
      case "three":
        paketDataOperator.value = "Tri Paket Internet";
        pulsaOperator.value = "Three";
        paketDataIcon.value = "assets/images/operator/three.png";
        pulsaIcon.value = "assets/images/operator/three.png";
        break;
      case "xl":
        paketDataOperator.value = "XL Paket Internet";
        pulsaOperator.value = "XL";
        paketDataIcon.value = "assets/images/operator/xl.png";
        pulsaIcon.value = "assets/images/operator/xl.png";
        break;
      default:
    }
  }

  List<dynamic> getProductList(List pricelist, String operator) {
    List result = [];
    pricelist.forEach((element) {
      if (element["product_description"] == operator) {
        result.add(element);
      }
    });

    result.sort(
      (a, b) {
        return (a["sell_price"] as int).compareTo(b["sell_price"] as int);
      },
    );
    return result;
  }

  void setPrepaidTopupPaketData(productData) async {
    if (paketDataPhoneNumberError.isFalse &&
        phoneNumber.text.isNotEmpty &&
        phoneNumber.text.length >= 10 &&
        paketDataCodeSelected.isNotEmpty) {
      // setTopUp
      // print("beli paket data");
      var refId = generateRandomString(6, "PREDAT");
      await IakprepaidProvider()
          .setTopUpPaketData(phoneNumber.text, refId, paketDataCodeSelected.value, paketDataNominalSelected.value, productData)
          .then((value) {
        print(value.body);
      }).catchError((err) {
        print(err);
      });
      Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
    } else {
      if (phoneNumber.text.length < 10) {
        Get.defaultDialog(title: "Peringatan", content: Text("Nomor minimal 10 angka"));
      } else {
        Get.defaultDialog(title: "Peringatan", content: Text("Pilih paket terlebih dahulu"));
      }
    }
  }

  void setPrepaidTopupPulsa() async {
    if (paketDataPhoneNumberError.isFalse && phoneNumber.text.isNotEmpty && phoneNumber.text.length >= 10 && pulsaCodeSelected.isNotEmpty) {
      // setTopUp
      // print("beli paket data");
      var refId = generateRandomString(6, "PREPUL");
      await IakprepaidProvider().setTopUpPulsa(phoneNumber.text, refId, pulsaCodeSelected.value, pulsaNominalSelected.value).then((value) {
        print(value.body);
      }).catchError((err) {
        print(err);
      });
      Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
    } else {
      if (phoneNumber.text.length < 10) {
        Get.defaultDialog(title: "Peringatan", content: Text("Nomor minimal 10 angka"));
      } else {
        Get.defaultDialog(title: "Peringatan", content: Text("Pilih nominal terlebih dahulu"));
      }
    }
  }

  void setPostpaidInquiryPln() async {
    if (customerId.text.isEmpty) {
      Get.snackbar("Peringatan", "Kolom ID Pelanggan/No Meter tidak boleh kosong");
    } else {
      if (customerId.text.length < 12) {
        Get.snackbar("Peringatan", "ID Pelanggan/No Meter kurang dari 12 digit");
      } else {
        var refId = generateRandomString(6, "POSPLN");
        isLoading.value = true;
        await IakpostpaidProvider().setInquiryPlnA(customerId.text, refId).then(
          (value) {
            isLoading.value = false;
            if (value.body["code"] == 400) {
              Get.defaultDialog(title: value.body["status"], content: Text(value.body["data"]["message"]));
            } else {
              var data = value.body;

              Get.toNamed(Routes.TRXDETAIL_POSTPAID, arguments: {"data": data, "createdAt": Timestamp.now()});
            }
          },
        );
      }
    }
  }

  void setPrepaidInquiryPln() async {
    if (customerId.text.isEmpty) {
      Get.snackbar("Peringatan", "Kolom ID Pelanggan/No Meter tidak boleh kosong");
    } else {
      if (customerId.text.length < 11) {
        Get.snackbar("Peringatan", "ID Pelanggan/No Meter kurang dari 11 digit");
      } else {
        if (nominalSelected.isEmpty) {
          Get.snackbar("Peringatan", "Pilih nominal token terlebih dahulu");
        } else {
          isLoading.value = true;
          await IakprepaidProvider().setInquiryPln(customerId.text).then((value) {
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
                    Text("Token Listrik ${NumberFormat("#,##0", "id_ID").format(int.parse(nominalSelected.value.toString()))}"),
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
                    Text("Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(nominalSelected.value.toString()))}"),
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
                            if (authC.balance.value < int.parse(nominalSelected.value)) {
                              isProceedLoading.value = false;
                              Get.defaultDialog(
                                  title: "Saldo tidak cukup", content: Text("Pastikan saldo anda cukup sebelum melakukan transaksi"));
                            } else {
                              var refId = generateRandomString(6, "PREPLN");
                              await IakprepaidProvider()
                                  .setTopUpPln(customerId.text, refId, codeSelected.value, nominalSelected.value, response["data"])
                                  .then((value) {
                                if (value.statusCode != 400) {
                                  nominalSelected.value = "";
                                  codeSelected.value = "";
                                  // Get.offNamed(Routes.TRANSACTIONS,
                                  //     arguments: {"refresh": true});
                                  Get.offNamed(Routes.TRXDETAIL_PREPAID, arguments: {"data": value.body});
                                } else {
                                  nominalSelected.value = "";
                                  codeSelected.value = "";
                                  Get.defaultDialog(title: "Gagal", content: Text("Terjadi kesalahan, mohon ulangi transaksi kembali"));
                                }
                              });

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
