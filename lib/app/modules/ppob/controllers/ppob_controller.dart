import 'dart:math';

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
    const Tab(text: 'Listrik'),
    const Tab(text: 'Paket Data'),
    const Tab(text: 'Pulsa'),
    const Tab(text: 'Internet/Wifi'),
    const Tab(text: 'PDAM'),
  ];

  final homeC = Get.find<HomeController>();

  late TabController tabC;
  late TextEditingController customerId;

  var isLoading = false.obs;
  var isGetDataLoading = false.obs;
  var isProceedLoading = false.obs;
  var nominalSelected = "".obs;
  var codeSelected = "".obs;
  var tokenSelected = false.obs;
  var pricelistPln = [].obs;

  @override
  void onInit() async {
    tabC = TabController(
        length: 5, vsync: this, animationDuration: Duration(milliseconds: 300));
    customerId = TextEditingController();
    if (preFilled) customerId.text = "530000000001";
    getPlnProduct();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    customerId.dispose();
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

  void getPlnProduct() async {
    if (devMode) print("Starting getPlnProduct");
    var timer = new Stopwatch();
    timer.start();
    isGetDataLoading.value = true;
    await IakprepaidProvider().getPlnProduct().then((value) {
      // print(value.body);
      pricelistPln.value = value.body;
    });
    isGetDataLoading.value = false;
    Get.snackbar("Waktu getPlnProduct:", timer.elapsed.toString(),
        duration: Duration(seconds: 1));
    timer.stop();
    timer.reset();
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
                                if (value.body["code"] == 200) {
                                  nominalSelected.value = "";
                                  codeSelected.value = "";
                                  Get.offNamed(Routes.TRANSACTIONS,
                                      arguments: {"refresh": true});
                                } else {
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
