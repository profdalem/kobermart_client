// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/models/Transactions.dart' as Trx;
import 'package:kobermart_client/firebase.dart';

import '../../../../config.dart';

class TransactionsController extends GetxController {
  RxList transactions = [].obs;
  RxList<Trx.Transaction> globaltrx = <Trx.Transaction>[].obs;
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
  void onInit() async {
    await getUserTransactions();
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

  List<Trx.Transaction> filteredTransaction(String code) {
    List<Trx.Transaction> result = [];
    // print(transactions.value[0]);

    switch (code) {
      case "all":
        result = globaltrx.value;
        break;
      case "now":
        globaltrx.value.forEach((element) {
          if (element.type == "topup" || element.type == "withdraw") {
            var history = element.data["transactionData"]['history'];
            if (element.data["transactionData"]['history'][history.length - 1]['code'] != 4) {
              result.add(element);
            }
          }
        });
        break;
      case "blc":
        globaltrx.value.forEach((element) {
          if (element.type == "topup" || element.type == "withdraw" || element.type == "transfer-in" || element.type == "transfer-out") {
            result.add(element);
          }
        });
        break;
      case "cb":
        globaltrx.value.forEach((element) {
          if (element.type == "ref" || element.type == "plan-a" || element.type == "plan-b") {
            result.add(element);
          }
        });
        break;
      case "done":
        globaltrx.value.forEach((element) {
          if (element.type == "topup" || element.type == "withdraw") {
            var history = element.data["transactionData"]['history'];
            if (element.data["transactionData"]['history'][history.length - 1]['code'] == 4) {
              result.add(element);
            }
          } else {
            result.add(element);
          }
        });
        break;
      default:
        result = globaltrx.value;
    }
    return result;
  }

  Future<void> getUserTransactions() async {
    if (devMode) print("starting getUserTransaction");
    isLoading.value = true;
    globaltrx.clear();
    final stopwatch = Stopwatch();
    stopwatch.start();

    try {
      await GlobalTrx.where("id", isEqualTo: Auth.currentUser!.uid).where("createdAt", isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now().subtract(Duration(days: days.value)))).get().then((value) {
        value.docs.forEach((element) {
          globaltrx.value.add(new Trx.Transaction.fromFirebase(element));
        });
      });
    } on FirebaseException catch (e) {
      print(e.message);
      print(e.stackTrace);
    }

    isLoading.value = false;
    if (devMode) print("getTransactions " + stopwatch.elapsed.toString());
    stopwatch.stop();
    stopwatch.reset();
  }
}
