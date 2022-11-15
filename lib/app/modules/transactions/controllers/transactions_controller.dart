import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/data/transaction_provider.dart';

class TransactionsController extends GetxController {
  RxList transactions = [].obs;
  var isLoading = false.obs;

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

  void getUserTransactions() async {
    isLoading.value = true;
    try {
      await TransactionProvider().getUserTransactions().then((value) {
        if (value.body != null) {
          transactions.value = value.body;
        } else {
          print(value.body);
          Get.snackbar("Error", "Gagal mendapatkan data transaksi");
        }
        isLoading.value = false;
      });
    } catch (e) {
      print("getUserTransaction error: " + e.toString());
    }
  }
}
