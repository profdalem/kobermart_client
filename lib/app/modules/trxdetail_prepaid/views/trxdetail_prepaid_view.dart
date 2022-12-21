import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../style.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/trx_status.dart';
import '../controllers/trxdetail_prepaid_controller.dart';

class TrxdetailPrepaidView extends GetView {
  TrxdetailPrepaidView({Key? key}) : super(key: key);
  final c = Get.put(TrxdetailPrepaidController());
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments["data"];
    var time = Timestamp.fromMillisecondsSinceEpoch(data["createdAt"]["_seconds"] * 1000);

    String icon = data["data"]["productData"]["icon_url"];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Prepaid',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              // Get.offAllNamed(Routes.TRANSACTIONS);
              Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
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
              child: CachedNetworkImage(
                imageUrl: icon,
                width: Get.width * 0.2,
              ),
            ),
            sb10,
            Container(
              alignment: Alignment.center,
              child: Text(
                "Dibuat ${DateFormat.yMMMd("id_ID").format(time.toDate())} ${DateFormat.Hm().format(time.toDate())} WITA",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            sb15,
            TrxDetailMainPanel(data: data),
            sb15,
            TrxDetailSerialNumber(
              data: data["data"]["transactionData"],
              customerData: data["data"]["customerData"],
            ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class TrxDetailMainPanel extends StatelessWidget {
  TrxDetailMainPanel({
    Key? key,
    required this.data,
  }) : super(key: key);
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    String notrx = "";
    String method = "Potong Saldo";
    String type = "";
    int nominal = 0;
    int status = 2;

    if (data != null) {
      nominal = int.parse(data["nominal"].toString());
      notrx = data["data"]["transactionData"]["ref_id"];

      switch (data["data"]["transactionData"]["rc"]) {
        case "00":
          status = 4;
          break;
        default:
          status = 2;
      }

      switch (notrx.substring(0, 6)) {
        case "PREPLN":
          type = "Token Listrik";
          break;
        case "PREDAT":
          type = "Paket Internet";
          break;
        case "PREPUL":
          type = "Pulsa";
          break;
        default:
          type = "Tipe Produk";
      }
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
                    sb10,
                    PanelTitle(title: "Jenis"),
                    Text(type),
                    sb10,
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
                    sb10,
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

// khusus transfer, muncul jika sudah transfer divalidasi
class TrxDetailSerialNumber extends StatelessWidget {
  TrxDetailSerialNumber({
    Key? key,
    required this.data,
    required this.customerData,
  }) : super(key: key);

  final data;
  final customerData;

  @override
  Widget build(BuildContext context) {
    Widget result = SizedBox();
    switch (data["rc"]) {
      case "00":
        result = Container(
          width: Get.width,
          decoration: Shadow1(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Text(
                "Token berhasil didapatkan!",
                style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              sb10,
              Text(
                "Pelanggan PLN:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${customerData["meter_no"]} / ${customerData["name"]}",
                style: TextStyle(fontSize: 20),
              ),
              sb10,
              Text(
                "Daya:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${data["sn"].toString().split("/").last} kWh",
                style: TextStyle(fontSize: 20),
              ),
              sb10,
              Text(
                "Token Anda:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                data["sn"].toString().split("/")[0],
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: data["sn"].toString().split("/")[0].replaceAll("-", "")),
                  ).then((value) => Get.snackbar("Berhasil", "Token listrik berhasil disalin"));
                },
                child: Text("Salin Token"),
              )
            ]),
          ),
        );

        break;
      case "39":
        result = Container(
          width: Get.width,
          decoration: Shadow1(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${data["rc"]}-${data["message"]}: Transaksi anda sedang diproses",
                ),
              ],
            ),
          ),
        );
        break;
      default:
        result = Container(
          width: Get.width,
          decoration: Shadow1(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ada kesalahan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                sb10,
                Text(
                  "${data["message"]} ${data["rc"]}: Terjadi kesalahan dalam proses transaksi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
    }

    return result;
  }
}
