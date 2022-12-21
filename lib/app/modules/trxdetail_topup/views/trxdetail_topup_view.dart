import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/models/Transactions.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/trxdetail_topup_controller.dart';
import '../../widgets/trx_status.dart';

class TrxdetailTopupView extends GetView<TrxdetailTopupController> {
  const TrxdetailTopupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Transaction data = Get.arguments["data"] as Transaction;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Topup',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                // Get.offAllNamed(Routes.TRANSACTIONS);
                Get.back();
              },
              icon: Icon(Icons.close)),
          actions: [
            if (data.status == "PENDING")
              IconButton(
                  tooltip: "Hapus",
                  onPressed: () {
                    GlobalTrx.doc(data.id).delete().then((value) => Get.toNamed(Routes.TRANSACTIONS, arguments: {"refresh": true}));
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ))
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
                  "assets/icons/icon-topup.svg",
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
              if (data.status == "ACTIVE")
                Column(
                  children: [
                    sb15,
                    TrxDetailPaymentMessage(),
                  ],
                ),
              if (data.status == "PENDING")
                Column(
                  children: [
                    sb15,
                    TrxDetailPaymentInfoShop(data: data),
                  ],
                ),
              if (data.data["collectorData"] != null)
                Column(
                  children: [
                    sb15,
                    TrxDetailCollector(),
                  ],
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
    String type = "Top Up";
    String method = data.getMethod();
    int status = data.getStatus();

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
                    PanelTitle(title: "Jenis"),
                    Text(type),
                    sb15,
                    PanelTitle(title: "Nominal"),
                    Text("Rp ${NumberFormat("#,##0", "id_ID").format(data.nominal)}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Status"),
                    TrxStatus(statusCode: status),
                    sb15,
                    PanelTitle(title: "Metode"),
                    Text(method),
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
class TrxDetailPaymentMessage extends StatelessWidget {
  const TrxDetailPaymentMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String method = "cash";
    Widget content = SizedBox();

    switch (method) {
      case "transfer":
        content = Container(
          decoration: Shadow1(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Text(
                "Transfer Dana Berhasil!",
                style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              sb10,
              RichText(
                  text: TextSpan(style: TextStyle(color: Colors.black), text: "Pembayaran anda telah diterima dan divalidasi oleh Admin ", children: [
                TextSpan(text: "(nama admin) "),
                TextSpan(text: "pada "),
                TextSpan(text: "20-06-2022", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " pukul "),
                TextSpan(text: "12.31 WITA", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "."),
              ]))
            ]),
          ),
        );
        break;
      default:
        content = Container(
          decoration: Shadow1(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Text(
                "Dana anda telah kami terima!",
                style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              sb10,
              RichText(
                  text: TextSpan(style: TextStyle(color: Colors.black), text: "Pembayaran anda telah diterima dan divalidasi oleh Admin ", children: [
                TextSpan(text: "(nama admin) "),
                TextSpan(text: "pada "),
                TextSpan(text: "20-06-2022", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " pukul "),
                TextSpan(text: "12.31 WITA", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "."),
              ]))
            ]),
          ),
        );
    }
    return content;
  }
}

// informasi cara bayar
class TrxDetailPaymentInfoShop extends StatelessWidget {
  final Transaction data;
  TrxDetailPaymentInfoShop({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int type = 0; // 0 transfer, 1 cash
    var typeTitle;
    var content;
    var btnText = "Buka QR Code";
    var btnFunction = () {
      Get.toNamed(Routes.QRCODE);
    };

    switch (data.getMethod()) {
      case METHOD_TRANSFER:
        typeTitle = "Top Up (transfer)";
        btnText = "Saya sudah bayar";
        btnFunction = () {};
        content = Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Text("1.")),
                Expanded(
                  flex: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Transfer sejumlah total harga yang tertera di atas ke rekening BRI a.n Kobermart "),
                      sb10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "1234567981283129318",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("copied");
                            },
                            child: Text(
                              "Salin",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            sb10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Text("2.")),
                Expanded(
                  flex: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Setelah melakukan transfer, klik tombol berikut"),
                    ],
                  ),
                )
              ],
            ),
            sb10
          ],
        );
        break;
      default:
        typeTitle = "Top Up (cash)";
        content = Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Text("1.")),
                Expanded(
                  flex: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kolektor kami akan melakukan penjemputan dana langsung ke alamat anda."),
                    ],
                  ),
                )
              ],
            ),
            sb10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Text("2.")),
                Expanded(
                  flex: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berikan dana kepada Kolektor dan Buka QR Code agar Kolektor dapat memvalidasi transaksi anda."),
                      sb10,
                    ],
                  ),
                )
              ],
            ),
          ],
        );
    }

    return Container(
      decoration: Shadow1(),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PanelTitle(title: "Tata Cara TopUp"),
                Text(
                  typeTitle,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            sb10,
            content,
            Container(
              width: double.infinity,
              child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)), onPressed: btnFunction, child: Text(btnText)),
            )
          ],
        ),
      ),
    );
  }
}

// informasi kolektor yang bertanggungjawab
class TrxDetailCollector extends StatelessWidget {
  const TrxDetailCollector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: Shadow1(),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          PanelTitle(title: "Pengantar"),
          sb10,
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider("https://i.pravatar.cc/150?img=18"),
            ),
            title: Text("Robert Xemeckis"),
            onTap: () {
              print("liht anggota");
            },
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () {},
            ),
          )
        ]),
      ),
    );
  }
}
