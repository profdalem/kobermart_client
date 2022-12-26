import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/modules/widgets/sucess_transfer.dart';
import 'package:kobermart_client/app/modules/widgets/sucess_withdrawal.dart';
import 'package:kobermart_client/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../config.dart';
import '../../../../style.dart';
import '../../../data/balance_provider.dart';
import '../../widgets/sucess.dart';

class InputnumberController extends GetxController {
  var method = Get.arguments["method"];
  var title = Get.arguments["title"];
  var recipient = Get.arguments["recipient"];
  var nominal = "0".obs;
  var isLoading = false.obs;
  final authC = Get.find<AuthController>();
  @override
  void onInit() {
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

  void openBottomSheetModal(context) {
    showMaterialModalBottomSheet(
      duration: Duration(milliseconds: 300),
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Transaksi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              sb10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jenis",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    title.toString().capitalizeFirst!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if(title != TRANSFER) sb10,
              if(title != TRANSFER) Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Metode",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    method.toString().capitalizeFirst!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              sb10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nominal",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Rp${NumberFormat("#,##0", "id_ID").format(int.parse(nominal.value))}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              sb10,
              Divider(),
              sb10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Biaya",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp${NumberFormat("#,##0", "id_ID").format(int.parse(nominal.value))}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              sb15,
              sb15,
              Obx(() => isLoading.value
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
                          child: Container(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    switch (title) {
                                      case WITHDRAWAL:
                                        setNewWithdraw();
                                        break;
                                        case TRANSFER:
                                        setNewTransfer();
                                        break;
                                      default:
                                        setNewTopUp();
                                    }
                                  },
                                  child: Text("Konfirmasi"))),
                        ),
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setNewTopUp() async {
    isLoading.value = true;
    if (nominal.value == '0') {
      Get.snackbar("Peringatan", "Nominal wajib diisi");
      isLoading.value = false;
    } else {
      if (int.parse(nominal.value) < 100000) {
        Get.snackbar("Peringatan", "Minimal topup Rp 100.000");
        isLoading.value = false;
      } else {
        await BalanceProvider().newTopup(nominal.value, method).then((value) {
          print(value.body);
          nominal.value = nominal.toString();
          Get.off(() => SuccessPage(), arguments: [nominal.value]);
        });
        devLog("Topup jalan");
      }
    }
    isLoading.value = false;
  }

  Future<void> setNewWithdraw() async {
    isLoading.value = true;
    if (nominal.value == '0') {
      Get.snackbar("Peringatan", "Nominal wajib diisi");
      isLoading.value = false;
    } else {
      if (int.parse(nominal.value) < 100000) {
        Get.snackbar("Peringatan", "Minimal withdraw Rp 100.000");
        isLoading.value = false;
      } else {
        if (int.parse(nominal.value) > authC.balance.value) {
          Get.snackbar("Peringatan", "Saldo anda tidak cukup");
          isLoading.value = false;
        } else {
          await BalanceProvider().newWithdraw(nominal.value, method).then((value) {
            print(value.body);
            nominal.value = nominal.toString();
            Get.off(() => SuccessWithdrawalPage(), arguments: [nominal.value]);
          });
        }
        devLog("Withdraw jalan");
      }
    }
    isLoading.value = false;
  }

  Future<void> setNewTransfer() async {
    isLoading.value = true;
    if (nominal.value == '0') {
      Get.snackbar("Peringatan", "Nominal wajib diisi");
      isLoading.value = false;
    } else {
      if (int.parse(nominal.value) < 10000) {
        Get.snackbar("Peringatan", "Minimal transfer Rp 10.000");
        isLoading.value = false;
      } else {
        if(int.parse(nominal.value) > authC.balance.value){
          Get.snackbar("Peringatan", "Saldo anda kurang");
          isLoading.value = false;
        } else {
          await BalanceProvider().newTransfer(recipient["id"], nominal.value).then((value) {
            print(value.body);
            nominal.value = nominal.toString();
            Get.off(() => SuccessTransferPage(), arguments: [nominal.value]);
          });
        devLog("Transfer jalan");
        }
      }
    }
    isLoading.value = false;
  }

  void addNumber(String number) {
    if (nominal.value[0] == "0" && number == "000") {
      nominal.value == "0";
    } else {
      if (nominal.value.length < 9) {
        if (nominal.value == "0") {
          nominal.value = number;
        } else {
          nominal.value = nominal.value + number;
        }
      }
      if (nominal.value.length > 9) {
        nominal.value = nominal.value.substring(0, 8);
      }
    }
  }

  void delNumber() {
    List nom = nominal.value.split("");
    if (nom.length > 1) {
      nom.removeLast();
      nominal.value = nom.join();
    } else {
      nominal.value = "0";
    }
  }
}
