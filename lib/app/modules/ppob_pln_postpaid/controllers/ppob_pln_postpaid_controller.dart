import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/data/iakpostpaid_provider.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../style.dart';
import '../../ppob_pulsadata/controllers/ppob_pulsadata_controller.dart';

class PpobPlnPostpaidController extends GetxController {
  late TextEditingController customerIdC;
  final authC = Get.find<AuthController>();
  var productList = [].obs;
  var historyList = [].obs;

  var isLoading = false.obs;
  var margin = 2000.obs;
  var customerId = "".obs;
  var fieldError = "".obs;

  @override
  void onInit() async {
    customerIdC = TextEditingController();
    setHistoryList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    customerIdC.dispose();
    super.onClose();
  }

  Future<void> setHistoryList() async {
    historyList.clear();
    await GlobalTrx.where("id", isEqualTo: authC.refId.value).where("type", isEqualTo: "postpaid").where("additional", isEqualTo: "pln").get().then((value) {
      value.docs.forEach((item) {
        historyList.add({"customerId": item.data()["data"]["customerData"]["customer_id"], "name": item.data()["data"]["customerData"]["name"]});
      });
    }).catchError((err) {
      print(err);
    });
    var temp = [];
    historyList.forEach((element) {
      temp.add(element["customerId"]);
    });
    temp = temp.toSet().toList();
    var temp2 = [];
    for (var i = 0; i < temp.length; i++) {
      for (var j = 0; j < historyList.length; j++) {
        if (temp[i] == historyList[j]["customerId"]) {
          temp2.add(historyList[j]);
          j = historyList.length;
        }
      }
    }
    historyList.value = temp2;
    if(devMode) historyList.add({"customerId": "530000000001", "name": "Success - 1 bill"});
    if(devMode) historyList.add({"customerId": "530000000002", "name": "Success - 8 bills"});
    if(devMode) historyList.add({"customerId": "530000000003", "name": "Inquiry - Time Out"});
    if(devMode) historyList.add({"customerId": "530000000004", "name": "Inquiry - Invoice Has Been Paid"});
    if(devMode) historyList.add({"customerId": "530000000005", "name": "Inquiry - Incorrect Destination Number"});
    if(devMode) historyList.add({"customerId": "530000000006", "name": "Payment - Payment Failed"});
    if(devMode) historyList.add({"customerId": "530000000007", "name": "Payment - Pending / transaction in process"});
    if(devMode) historyList.add({"customerId": "530000000008", "name": "Payment - MISC Error / Biller System Error"});
    if(devMode) print(historyList);
  }

  void openBottomSheetModal(BuildContext context, dynamic content1, dynamic content2, dynamic action, bool isDismissible) {
    if (FocusManager.instance.primaryFocus!.hasFocus) FocusManager.instance.primaryFocus?.unfocus();
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      isDismissible: isDismissible,
      duration: Duration(milliseconds: 300),
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: content1,
              ),
              if (content1 != null)
                Column(
                  children: [
                    sb10,
                    Divider(thickness: 10, color: Colors.blueGrey.shade50),
                    sb10,
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: content2,
              ),
              sb15,
              if (action != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ubah"))),
                              Expanded(
                                child: Container(height: 50, child: ElevatedButton(onPressed: action, child: Text("Konfirmasi"))),
                              ),
                            ],
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> plnPostpaidController(BuildContext context) async {
    isLoading.value = true;
    Get.generalDialog(
        barrierDismissible: false,
        pageBuilder: (context, a, b) => Center(
              child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.blue),
            ));
    await IakpostpaidProvider().setInquiryPlnA(customerId.value).timeout(Duration(seconds: 30)).then((value) {
      isLoading.value = false;
      if (Get.isDialogOpen!) {
        Get.back();
      }
      if (value.body["code"] == 400) {
        openBottomSheetModal(
            context,
            null,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gagal",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                sb10,
                Text(
                  "Nomor meter yang anda masukkan salah.",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                sb15,
                Container(
                  width: Get.width,
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Tutup")),
                )
              ],
            ),
            null,
            false);
      } else {
        var period = [];
        if (int.parse(value.body["data"]["desc"]["lembar_tagihan"].toString()) > 1) {
          (value.body["data"]["desc"]["tagihan"]["detail"] as List).forEach((element) {
            period.add(getPeriod(element["periode"]));
          });
        } else {
          period.add(getPeriod(value.body["data"]["period"]));
        }
        openBottomSheetModal(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Info Pelanggan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                sb10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "ID Pelanggan",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        value.body["data"]["hp"],
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                sb10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Nama",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        censorHalf(value.body["data"]["tr_name"]),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                sb10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Periode",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        period.join(", "),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Transaksi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                sb10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Jumlah Tagihan",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Rp" + NumberFormat("#,##0", "id_ID").format(value.body["data"]["nominal"]),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                sb10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Biaya Transaksi",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Rp${NumberFormat("#,##0", "id_ID").format(value.body["data"]["admin"])}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                sb10,
                MySeparator(
                  color: Colors.blueGrey.shade100,
                  height: 1,
                ),
                sb10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rp${NumberFormat("#,##0", "id_ID").format(value.body["data"]["price"])}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                sb15,
              ],
            ), () {
          setPostpaidPayment(value.body["data"]["tr_id"], value.body["data"]["price"]);
        }, false);
      }
    });
  }

  void setPostpaidPayment(String trId, int nominal) async {
    isLoading.value = true;
    if (fieldError.isEmpty && customerId.isNotEmpty) {
      if (nominal <= authC.balance.value) {
      await IakpostpaidProvider().setPayment(trId, nominal).then((value) {
        print(value.body["success"]);
        if (value.body["success"]) {
          Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
          print(value.body);
        } else {
          Get.back();
          Get.defaultDialog(title: "Terjadi kesalahan", content: Text("Mohon coba lagi nanti"));
        }
      }).catchError((err) {
        print(err);
      });
      Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
      } else {
        Get.back();
        Get.defaultDialog(
            title: "Peringatan",
            content: Column(
              children: [
                Text("Saldo anda kurang."),
                Text("Lakukan top Up saldo sekarang?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: () => Get.back(), child: Text("Nanti")),
                    ElevatedButton(onPressed: () => Get.offNamed(Routes.SELECTMETHOD, arguments: {"title": TOPUP}), child: Text("Top Up"))
                  ],
                )
              ],
            ));
      }
    } else {
      Get.back();
      Get.defaultDialog(title: "Peringatan", content: Text("Nomor meter tidak boleh kosong"));
    }
    isLoading.value = false;
  }
}
