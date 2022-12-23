import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/selectmethod_controller.dart';

class SelectmethodView extends GetView<SelectmethodController> {
  SelectmethodView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final title = Get.arguments["title"];
    var cash_subtitle = "";
    var transfer_subtitle = "";

    switch (title) {
      case TOPUP:
        cash_subtitle = "Dana dijemput oleh kolektor";
        transfer_subtitle = "Dana dikirim melalui rekening bank";
        break;
      case WITHDRAWAL:
        cash_subtitle = "Dana diantar oleh kolektor";
        transfer_subtitle = "Dana dikirim ke rekening bank anda";
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments["title"]),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb15,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Saldo anda: "),
                      Text(
                        "Rp${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                      child: Text(
                    "Pilih metode:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              height: double.infinity,
              color: Colors.grey.shade100,
              child: ListView(
                padding: EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 0),
                children: [
                  Card(
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(Routes.INPUTNUMBER, arguments: {"method": METHOD_CASH, "title": title});
                      },
                      title: Text(
                        "Tunai",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(cash_subtitle),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(Routes.INPUTNUMBER, arguments: {"method": METHOD_TRANSFER, "title": title});
                      },
                      title: Text(
                        "Transfer",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(transfer_subtitle),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
