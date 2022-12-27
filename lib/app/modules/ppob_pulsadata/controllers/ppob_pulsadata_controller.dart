import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../style.dart';
import '../../../data/iakprepaid_provider.dart';

class PpobPulsadataController extends GetxController {
  late TextEditingController phoneNumber;
  late dynamic getContact;
  RxList<dynamic> listPaketData = [].obs;
  RxList<dynamic> listPaketDataWithSellPrice = [].obs;
  var listPulsa = [10000, 100000, 1000000, 150000, 20000, 200000, 25000, 30000, 300000, 5000, 50000, 500000].obs;

  final authC = Get.find<AuthController>();

  var contactNumber = "".obs;
  var isPulsa = true.obs;
  var isLoading = false.obs;
  var marginPulsa = 2000.obs;
  var marginData = 2000.obs;

  var paketDataOperator = "".obs;
  var pulsaOperator = "".obs;
  var paketDataIcon = "".obs;
  var pulsaIcon = "".obs;

  var currentPricelistData = "";

  var getOpr = true;
  var fieldError = "".obs;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      if (Get.arguments["product"] == "pulsa") {
        isPulsa.value = true;
      } else {
        isPulsa.value = false;
      }
    }
    marginData.value = authC.settings["margin_ppob"];
    marginPulsa.value = authC.settings["margin_ppob"];
    phoneNumber = TextEditingController();
    listPulsa.sort((a, b) => a - b);
    getContact = () async {
      await Permission.contacts.request().then((value) async {
        if (value == PermissionStatus.granted) {
          print("contact");
          try {
            await ContactsService.openDeviceContactPicker(androidLocalizedLabels: true).then((value) {
              String result = "";
              if (value != null) {
                if (value.phones != null) {
                  var contacts = value.phones!;
                  Get.defaultDialog(
                      title: "Pilih Nomor",
                      content: Column(
                        children: List.generate(
                            contacts.length,
                            (index) => TextButton(
                                onPressed: () {
                                  result = contacts[index].value!;
                                  List temp = [];
                                  if (result.isNotEmpty) {
                                    for (var i = 0; i < result.length; i++) {
                                      if (result[i].isNum) {
                                        temp.add(result[i]);
                                      }
                                    }
                                    if (temp[0] == "8") {
                                      temp.insert(0, "0");
                                    }
                                    if (temp[0] == "6" && temp[1] == "2") {
                                      temp.removeAt(0);
                                      temp.removeAt(0);
                                      temp.insert(0, "0");
                                    }
                                  }
                                  getOpr = true;
                                  phoneNumber.text = temp.join();
                                  contactNumber.value = temp.join();
                                  Get.back();
                                },
                                child: Text(contacts[index].value!))),
                      ));
                } else {
                  Get.snackbar("Gagal", "Kontak tidak memiliki nomor telepon");
                }
              }
            }).catchError((error) {
              print(error);
            });
          } catch (e) {
            print(e);
          }
        } else {
          Get.snackbar("Ijin Ditolak", "Tidak dapat mengakses kontak karena tidak diijinkan");
        }
      });
    };
    contactNumber.listen((event) async {
      print(pulsaOperator.value);
      print(getOpr);
      if (event.length > 1 && (event[0] != "0" || event[1] != "8")) {
        fieldError.value = "Nomor harus diawali dengan angka 08";
      } else {
        fieldError.value = "";
      }
      if (event.length < 4) {
        getOpr = true;
        resetOpr();
      }
      if (event.length >= 4 && getOpr) {
        getOperator(4, event.substring(0, 4));
        await getPricelist();
        getOpr = false;
      }
    });
    isPulsa.listen((event) async {
      if (!event) {
        if (listPaketData.isEmpty) await getPricelist();
      }
    });
    listPaketData.listen((event) async {});
    if(devMode) contactNumber.value = "085313924122";
    if(devMode) phoneNumber.text = "085313924122";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    contactNumber.close();
    isPulsa.close();
    super.onClose();
  }

  Future<void> getPricelist() async {
    devLog("getprice loading...");
    if (paketDataOperator.isNotEmpty) {
      String opr = paketDataOperator.toLowerCase().replaceAll(" ", "_");
      if (opr != currentPricelistData || isLoading.isTrue) {
        isLoading.value = true;
        listPaketDataWithSellPrice.clear();
        try {
          await IakprepaidProvider().getPrepaidPricelist("data", opr).then((value) async {
            listPaketData.value = value.body["data"]["pricelist"] as List<Object?>;

            await PrepaidPricelist.doc("data").collection(opr).where("status", isEqualTo: "active").get().then((pricelists) {
              listPaketData.forEach((element) {
                pricelists.docs.forEach((item) {
                  if (item.id == element["product_code"]) {
                    listPaketDataWithSellPrice.add({...element as Map, ...item.data()});
                  }
                });
              });
            });
            listPaketDataWithSellPrice.sort((a, b) => a["sell_price"] - b["sell_price"]);
            currentPricelistData = opr;
          });
        } catch (e) {
          print(e);
          Get.snackbar("Gangguan", e.toString());
        }
      }
      isLoading.value = false;
    }
  }

  List filteredDataList(List data) {
    List temp = [];
    if (listPaketData.isEmpty) {
      temp = data;
      temp.sort((a, b) => a["product_price"] - b["product_price"]);
      return temp;
    } else {
      temp = listPaketData.where((el) => el["product_description"] == paketDataOperator.value).toList();
      temp.sort((a, b) => a["product_price"] - b["product_price"]);
      return temp;
    }
  }

  void resetOpr() {
    paketDataIcon.value = "";
    paketDataOperator.value = "";
    pulsaIcon.value = "";
    pulsaOperator.value = "";
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

  void getOperator(int length, String prefix) {
    print("get operator running");
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

  void paketDataItemController(BuildContext context, int index) {
    openBottomSheetModal(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            sb10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Nomor",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    contactNumber.value,
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
                    "Paket Data",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    filteredDataList(listPaketData)[index]["product_details"],
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
              children: [
                Text(
                  "Harga",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Rp${NumberFormat("#,##0", "id_ID").format(filteredDataList(listPaketData)[index]["product_price"] + marginData.value)}",
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
                  "Total Biaya",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp${NumberFormat("#,##0", "id_ID").format(filteredDataList(listPaketData)[index]["product_price"] + marginData.value)}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            sb15,
          ],
        ), () {
      setPrepaidTopupPaketData(filteredDataList(listPaketData)[index]["product_code"], filteredDataList(listPaketDataWithSellPrice)[index]["sell_price"] != null
                                                          ? listPaketDataWithSellPrice[index]["sell_price"]
                                                          : listPaketDataWithSellPrice[index]["product_price"] + marginData.value);
    }, false);
  }

  void paketDataItemDetailsController(BuildContext context, int index) {
    openBottomSheetModal(
        context,
        null,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              filteredDataList(listPaketData)[index]["product_nominal"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            sb10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    filteredDataList(listPaketData)[index]["product_details"],
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            sb10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Masa aktif ${filteredDataList(listPaketData)[index]["active_period"]} hari",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            sb15,
            Container(width: Get.width, child: TextButton(onPressed: () => Get.back(), child: Text("Tutup"))),
          ],
        ),
        null,
        true);
  }

  void pulsaItemController(BuildContext context, int nominal) {
    openBottomSheetModal(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            sb10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Nomor",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    contactNumber.value,
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
                    "Nominal Pulsa",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    NumberFormat("#,##0", "id_ID").format(nominal),
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
              children: [
                Text(
                  "Harga",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Rp${NumberFormat("#,##0", "id_ID").format(nominal + marginData.value)}",
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
                  "Total Biaya",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp${NumberFormat("#,##0", "id_ID").format(nominal + marginData.value)}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            sb15,
          ],
        ), () {
      setPrepaidTopupPulsa("pulsa" + nominal.toString(), nominal + marginData.value);
    }, false);
  }

  void setPrepaidTopupPulsa(String code, int price) async {
    isLoading.value = true;
    if (fieldError.isEmpty && contactNumber.isNotEmpty && contactNumber.value.length >= 10 && code.isNotEmpty) {
      if (price <= authC.balance.value) {
        await IakprepaidProvider().setTopUp(contactNumber.value, "PREPUL", code, price, "pulsa").then((value) {
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
        // Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
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
                    TextButton(onPressed: ()=> Get.back(), child: Text("Nanti")),
                    ElevatedButton(onPressed: () => Get.offNamed(Routes.SELECTMETHOD, arguments: {"title": TOPUP}), child: Text("Top Up"))],
                )
              ],
            ));
      }
    } else {
      Get.back();
      if (phoneNumber.text.length < 10) {
        Get.defaultDialog(title: "Peringatan", content: Text("Nomor minimal 10 angka"));
      } else {
        Get.defaultDialog(title: "Peringatan", content: Text("Pilih nominal terlebih dahulu"));
      }
    }
    isLoading.value = false;
  }

  void setPrepaidTopupPaketData(String code, int price) async {
    isLoading.value = true;
    if (fieldError.isEmpty && contactNumber.isNotEmpty && contactNumber.value.length >= 10 && code.isNotEmpty) {
      if (price <= authC.balance.value) {
        await IakprepaidProvider().setTopUp(contactNumber.value, "PREDAT", code, price, "data").then((value) {
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
        // Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
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
                    TextButton(onPressed: ()=> Get.back(), child: Text("Nanti")),
                    ElevatedButton(onPressed: () => Get.offNamed(Routes.SELECTMETHOD, arguments: {"title": TOPUP}), child: Text("Top Up"))],
                )
              ],
            ));
      }
    } else {
      Get.back();
      if (phoneNumber.text.length < 10) {
        Get.defaultDialog(title: "Peringatan", content: Text("Nomor minimal 10 angka"));
      } else {
        Get.defaultDialog(title: "Peringatan", content: Text("Pilih nominal terlebih dahulu"));
      }
    }
    isLoading.value = false;
  }

}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black}) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
