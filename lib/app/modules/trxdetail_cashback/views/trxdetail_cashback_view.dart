import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/modules/widgets/trx_status.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/trxdetail_cashback_controller.dart';

class TrxdetailCashbackView extends GetView<TrxdetailCashbackController> {
  const TrxdetailCashbackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var createdAt = Timestamp.now();
    Color? iconColor = Colors.blue;

    if (Get.arguments != null) {
      createdAt = Get.arguments["createdAt"];
      iconColor = Get.arguments["iconColor"];
    }
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Cashback',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.TRANSACTIONS);
              },
              icon: Icon(Icons.close)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CART);
                },
                icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sb15,
              Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/icon-cashback.svg",
                  width: Get.width * 0.12,
                  color: iconColor,
                ),
              ),
              sb10,
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Dibuat ${DateFormat.yMMMd("id_ID").format(createdAt.toDate())} ${DateFormat.Hm().format(createdAt.toDate())} WITA",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              sb15,
              TrxDetailMainPanel(arguments: Get.arguments),
              Container(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextButton(
                    child: Text("Kembali ke Beranda"),
                    onPressed: () {
                      Get.offAndToNamed(Routes.HOME);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TrxDetailMainPanel extends StatelessWidget {
  final dynamic arguments;
  TrxDetailMainPanel({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String notrx = "TRX88432389293";
    String type = arguments["type"];
    int status = 4;
    int nominal = arguments["nominal"];
    String message = arguments["message"];

    switch (arguments["type"]) {
      case "ref":
        type = "Referral";
        break;
      case "plan-a":
        type = "Plan A";
        break;
      default:
        type = "Plan B";
    }

    if (!arguments["isCount"]) {
      status = 5;
    }

    return Container(
      decoration: Shadow1(),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PanelTitle(title: "No. Transaksi"),
                    GestureDetector(
                      onTap: () {
                        print(notrx);
                      },
                      child: Text(
                        notrx,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    sb15,
                    PanelTitle(title: "Nominal"),
                    Text(
                        "Rp ${NumberFormat("#,##0", "id_ID").format(nominal)}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Status"),
                    TrxStatus(statusCode: status),
                    sb15,
                    PanelTitle(title: "Jenis"),
                    Text("Cashback (${type})"),
                  ],
                )
              ],
            ),
            sb15,
            PanelTitle(title: "Keterangan"),
            Row(
              children: [
                Text(message),
                SizedBox(
                  width: 5,
                ),
                arguments["type"] == "ref"
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.TOKENDETAIL);
                        },
                        child: Text(
                          "Lihat",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
