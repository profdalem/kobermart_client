// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:kobermart_client/app/data/transaction_provider.dart';

import '../../../../config.dart';

class TransactionsController extends GetxController {
  RxList transactions = [].obs;
  var isLoading = false.obs;

  var filters = [
    {"code": "all", "name": "Semua"},
    {"code": "now", "name": "Berlangsung"},
    {"code": "blc", "name": "Saldo"},
    {"code": "cb", "name": "Cashback"},
    {"code": "shop", "name": "Belanja"},
    {"code": "done", "name": "Selesai"},
  ];

  var filterBy = "all".obs;

  var days = 7.obs;

  @override
  void onInit() {
    getUserTransactions();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List filteredTransaction(String code) {
    var result = [];
    // print(transactions.value[0]);

    switch (code) {
      case "all":
        result = transactions.value;
        break;
      case "now":
        transactions.value.forEach((element) {
          if (element["type"] == "topup" || element["type"] == "withdraw") {
            var history = element['history'];
            if (element['history'][history.length - 1]['code'] != 4) {
              result.add(element);
            }
          }
        });
        break;
      case "blc":
        transactions.value.forEach((element) {
          if (element["type"] == "topup" ||
              element["type"] == "withdraw" ||
              element["type"] == "transfer-in" ||
              element["type"] == "transfer-out") {
            result.add(element);
          }
        });
        break;
      case "cb":
        transactions.value.forEach((element) {
          if (element["type"] == "ref" ||
              element["type"] == "plan-a" ||
              element["type"] == "plan-b") {
            result.add(element);
          }
        });
        break;
      case "done":
        transactions.value.forEach((element) {
          if (element["type"] == "topup" || element["type"] == "withdraw") {
            var history = element['history'];
            if (element['history'][history.length - 1]['code'] == 4) {
              result.add(element);
            }
          } else {
            result.add(element);
          }
        });
        break;
      default:
        result = transactions.value;
    }
    return result;
  }

  void getUserTransactions() async {
    if (devMode) print("starting getUserTransaction");
    isLoading.value = true;
    transactions.clear();
    final stopwatch = Stopwatch();
    stopwatch.start();
    transactions.clear();
    try {
      await TransactionProvider().getUserTransactions(days.value).then((value) {
        if (value.body != null) {
          transactions.value = value.body;
        } else {
          Get.snackbar("Error", "Gagal mendapatkan data transaksi");
        }
        isLoading.value = false;
      });
    } catch (e) {
      print("getUserTransaction error: " + e.toString());
    }
    if (devMode) Get.snackbar("Waktu", stopwatch.elapsed.toString());
    stopwatch.stop();
    stopwatch.reset();
  }
}
