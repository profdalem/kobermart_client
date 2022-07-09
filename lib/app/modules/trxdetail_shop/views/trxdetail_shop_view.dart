import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/trxdetail_shop_controller.dart';
import '../../widgets/trx_status.dart';

class TrxdetailShopView extends GetView<TrxdetailShopController> {
  const TrxdetailShopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Belanja',
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
                  "assets/icons/icon-belanja.svg",
                  width: Get.width * 0.12,
                ),
              ),
              sb10,
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Dibuat 19-06-2022  12.30 WITA",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              sb15,
              TrxDetailMainPanel(),
              sb15,
              TrxDetailPaymentMessage(),
              sb15,
              TrxDetailProductList(),
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

class TrxDetailPaymentMessage extends StatelessWidget {
  const TrxDetailPaymentMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Shadow1(),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(children: [
          Text(
            "Pembayaran Berhasil!",
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
}

class TrxDetailProductList extends StatelessWidget {
  const TrxDetailProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: [
                Expanded(
                  flex: 5,
                  child: PanelTitle(title: "Detail Pesanan"),
                ),
                Expanded(flex: 1, child: PanelTitle(title: "Qty")),
                Expanded(flex: 2, child: PanelTitle(title: "Harga")),
              ],
            ),
            sb10,
            Column(
              children: List.generate(
                3,
                (index) => ItemListProduct(),
              ),
            ),
            Divider(),
            sb10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total harga:",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Rp 120.000",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TrxDetailMainPanel extends StatelessWidget {
  const TrxDetailMainPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String notrx = "TRX88432389293";
    String type = "Belanja";
    String method = "Transfer";
    int status = 2;
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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

class ItemListProduct extends StatelessWidget {
  const ItemListProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: LayoutBuilder(builder: (context, constraint) {
              return Container(
                width: constraint.maxWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                "https://picsum.photos/200/300",
                              ),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: Get.width * 0.4,
                      child: Text(
                        "Kopi Sachet 3in1 Instant Coffee Mocca ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          Expanded(
            flex: 1,
            child: Text("3"),
          ),
          Expanded(flex: 2, child: Text("Rp 12.000")),
        ],
      ),
    );
  }
}

class TrxDetailPaymentInfoShop extends StatelessWidget {
  const TrxDetailPaymentInfoShop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int type = 2; // 0 cash, 1 saldo, 2 transfer
    var typeTitle;
    var content;
    var btnText = "Buka QR Code";
    var btnFunction = () {
      Get.toNamed(Routes.QRCODE);
    };

    switch (type) {
      case 2:
        typeTitle = "Belanja (transfer)";
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
                      sb10,
                    ],
                  ),
                )
              ],
            )
          ],
        );
        break;
      case 1:
        typeTitle = "Belanja (saldo)";
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
                          "Dana akan otomatis terpotong dari saldo anda sejumlah nominal berbelanja."),
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
                          "Kurir akan mengantarkan barang ke alamat anda kemudian meminta QR Code yang digunakan sebagai bentuk validasi pengiriman barang."),
                      sb10,
                    ],
                  ),
                )
              ],
            )
          ],
        );

        break;
      default:
        typeTitle = "Belanja (cash)";
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
                          "Kolektor kami akan melakukan penjemputan dana dan pengiriman barang langsung ke alamat anda."),
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
                          "Berikan dana kepada Kolektor dan Buka QR Code agar Kolektor dapat memvalidasi transaksi anda setelah barang anda terima."),
                      sb10,
                    ],
                  ),
                )
              ],
            )
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
                PanelTitle(title: "Tata Cara Pembayaran"),
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
