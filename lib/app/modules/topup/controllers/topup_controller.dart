import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/style.dart';

import '../../../data/balance_provider.dart';
import '../../widgets/sucess.dart';

class TopupController extends GetxController {
  late TextEditingController nominal;
  var jumlah = 0.obs;
  var selectedMethod = "cash".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    nominal = TextEditingController();
    nominal.text = "".toString();
    super.onInit();
  }

  @override
  void onReady() {
    Get.defaultDialog(
      title: "Tulis Nominal",
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              onSubmitted: (value) => Get.back(),
              controller: nominal,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefix: Text("Rp "),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  // isDense: true,
                  contentPadding: EdgeInsets.all(12)),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                if (value.isNotEmpty) {
                  jumlah.value = int.parse(nominal.text);
                } else {
                  jumlah.value = 0;
                }
              },
              onTap: () {
                nominal.text = "";
              },
            ),
            sb5,
            Text(
              "Minimal Rp 100.000",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
      barrierDismissible: false,
      confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Simpan")),
    ).then((value) => Get.defaultDialog(
        title: "Pilih Metode",
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 100,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedMethod.value = "cash";
                      Get.back();
                    },
                    child: Text("Cash"),
                  ),
                ),
              ),
              sb15,
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedMethod.value = "transfer";
                      Get.back();
                    },
                    child: Text("Transfer"),
                  ),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false));
    super.onReady();
  }

  @override
  void onClose() {
    nominal.dispose();
    super.onClose();
  }

  Future<void> setNewTopUp() async {
    isLoading.value = true;
    if (nominal.text.isEmpty || nominal.text == '0') {
      Get.snackbar("Peringatan", "Nominal wajib diisi");
      isLoading.value = false;
    } else {
      if (int.parse(nominal.text) < 100000) {
        Get.snackbar("Peringatan", "Minimal topup Rp 100.000");
        isLoading.value = false;
      } else {
        await BalanceProvider().newTopup(nominal.text, selectedMethod.value).then((value) {
          print(value.body);
          Get.off(() => SuccessPage(), arguments: [nominal.text]);
        });
        devLog("Topup jalan");
        isLoading.value = false;
      }
    }
  }
}
