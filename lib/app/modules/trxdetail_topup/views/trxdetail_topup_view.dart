import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/trxdetail_topup_controller.dart';
import '../../widgets/trx_status.dart';

class TrxdetailTopupView extends GetView<TrxdetailTopupController> {
  const TrxdetailTopupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  "assets/icons/icon-topup.svg",
                  width: Get.width * 0.12,
                ),
              ),
              sb10,
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Dibuat ${DateFormat.yMMMd("id_ID").format(Get.arguments["createdAt"].toDate())} ${DateFormat.Hm().format(Get.arguments["createdAt"].toDate())} WITA",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              sb15,
              TrxDetailMainPanel(arguments: Get.arguments),
              sb15,
              TrxDetailPaymentMessage(),
              sb15,
              TrxDetailPaymentInfoShop(),
              sb15,
              TrxDetailCollector(),
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
    String type = "Top Up";
    String method = arguments["method"];
    int status = arguments["code"];

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
                    Text(
                        "Rp ${NumberFormat("#,##0", "id_ID").format(arguments["nominal"])}"),
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
                style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              sb10,
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text:
                          "Pembayaran anda telah diterima dan divalidasi oleh Admin ",
                      children: [
                    TextSpan(text: "(nama admin) "),
                    TextSpan(text: "pada "),
                    TextSpan(
                        text: "20-06-2022",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " pukul "),
                    TextSpan(
                        text: "12.31 WITA",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              sb10,
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text:
                          "Pembayaran anda telah diterima dan divalidasi oleh Admin ",
                      children: [
                    TextSpan(text: "(nama admin) "),
                    TextSpan(text: "pada "),
                    TextSpan(
                        text: "20-06-2022",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " pukul "),
                    TextSpan(
                        text: "12.31 WITA",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
  const TrxDetailPaymentInfoShop({
    Key? key,
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

    switch (type) {
      case 1:
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
                      Text(
                          "Transfer sejumlah total harga yang tertera di atas ke rekening BRI a.n Kobermart "),
                      sb10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "1234567981283129318",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                      Text(
                          "Kolektor kami akan melakukan penjemputan dana langsung ke alamat anda."),
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
                      Text(
                          "Berikan dana kepada Kolektor dan Buka QR Code agar Kolektor dapat memvalidasi transaksi anda."),
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
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: btnFunction,
                  child: Text(btnText)),
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
              backgroundImage: CachedNetworkImageProvider(
                  "https://i.pravatar.cc/150?img=18"),
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
