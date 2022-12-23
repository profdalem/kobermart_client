import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/models/Transactions.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/trxdetail_transfer_controller.dart';
import '../../widgets/trx_status.dart';

class TrxdetailTransferView extends GetView<TrxdetailTransferController> {
  const TrxdetailTransferView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Transaction data = Get.arguments["data"];
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Transfer',
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
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sb15,
              Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/icon-transfer.svg",
                  width: Get.width * 0.12,
                ),
              ),
              sb10,
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Dibuat ${DateFormat.yMMMd("id_ID").format(data.createdAt)} ${DateFormat.Hm().format(data.createdAt)} WITA",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              sb15,
              TrxDetailMainPanel(data: data),
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
  final Transaction data;
  TrxDetailMainPanel({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String notrx = data.id;
    String method = "Potong Saldo";
    String text1 = "Tujuan";
    String name = data.data["customerData"]["recipientName"];
    int nominal = data.nominal;
    int status = 4;

    switch (data.type) {
      case "transfer-in":
        text1 = "Pengirim";
        name = data.data["customerData"]["senderName"];
        break;
      default:
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
                    PanelTitle(title: text1),
                    Text(name),
                    sb15,
                    PanelTitle(title: "Nominal"),
                    Text("Rp ${NumberFormat("#,##0", "id_ID").format(nominal)}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Metode"),
                    Text(method),
                    sb15,
                    PanelTitle(title: "Biaya"),
                    Text("Rp 0,-"),
                    sb15,
                    PanelTitle(title: "Status"),
                    TrxStatus(statusCode: status),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
