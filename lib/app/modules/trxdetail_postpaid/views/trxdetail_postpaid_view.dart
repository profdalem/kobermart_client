// ignore_for_file: invalid_return_type_for_catch_error
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/data/iakpostpaid_provider.dart';

import '../../../../style.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/trx_status.dart';
import '../controllers/trxdetail_postpaid_controller.dart';

class TrxdetailPostpaidView extends GetView<TrxdetailPostpaidController> {
  TrxdetailPostpaidView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments["data"]["data"]["transactionData"];
    var detail = data["desc"]["tagihan"]["detail"];
    print(data["ref_id"].toString().toLowerCase().substring(3, 6));

    String logo = "assets/icons/logo_pln.svg";
    String product = "";

    int nominal = data["price"];
    int status = 1;
    var createdAt = Timestamp.now();
    if (Get.arguments["createdAt"] != null) {
      createdAt = Get.arguments["createdAt"];
    }

    switch (data["ref_id"].toString().toLowerCase().substring(3, 6)) {
      case "pln":
        logo = "assets/icons/logo_pln.svg";
        product = "Tagihan Listrik";
        break;
      default:
        logo = "assets/icons/logo_pln.svg";
        product = "Produk";
    }

    switch (data["message"]) {
      case "PAYMENT SUCCESS":
        status = 4;

        break;
      case "PEMBAYARAN GAGAL":
        status = 7;
        break;
      case "PENDING / TRANSAKSI SEDANG DIPROSES":
        status = 2;
        break;
      default:
        status = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Transaksi',
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
                logo,
                width: Get.width * 0.12,
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
            Container(
              decoration: Shadow1(),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PanelTitle(title: "No. Transaksi"),
                            GestureDetector(
                              onTap: () {
                                print("notrx");
                              },
                              child: Text(
                                data["ref_id"],
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            sb15,
                            PanelTitle(title: "Jenis"),
                            Text(product),
                            sb15,
                            PanelTitle(title: "Total Biaya"),
                            Text("Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(nominal.toString()))}"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            PanelTitle(title: "Metode"),
                            Text("Potong Saldo"),
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
            ),
            sb15,
            Container(
              width: double.infinity,
              decoration: Shadow1(),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PanelTitle(title: "Rincian Tagihan"),
                    sb15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama Rekening:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(data["tr_name"]),
                            sb10,
                            Text(
                              "Tarif/Daya:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${data["desc"]["tarif"]}/${data["desc"]["daya"]} VA"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Nomor Meter:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(data["hp"]),
                            sb10,
                            Text(
                              "Keterangan:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            data["desc"]["lembar_tagihan"] == "1"
                                ? Text("Belum terlambat")
                                : Text(
                                    "Terlambat",
                                    style: TextStyle(color: Colors.red.shade700),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    sb10,
                    PanelTitle(
                      title: "Komponen (${data["desc"]["lembar_tagihan"]})",
                    ),
                    sb10,
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          data["desc"]["tagihan"]["detail"].length,
                          (index) => Container(
                            width: 190,
                            height: double.infinity,
                            padding: EdgeInsets.only(right: 10),
                            child: Card(
                              color: Colors.grey.shade50,
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 35,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade100,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(2), topRight: Radius.circular(2)),
                                    ),
                                    child: Text(
                                      DateFormat.yMMMM('id_ID').format(DateTime(int.parse(detail[index]["periode"].toString().substring(0, 4)),
                                          int.parse(detail[index]["periode"].toString().substring(5, 6)))),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Tagihan: "),
                                                    Text(
                                                      "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(detail[index]["nilai_tagihan"].toString()))}",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                sb5,
                                                Row(
                                                  children: [
                                                    Text("Admin: "),
                                                    Text(
                                                      "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(detail[index]["admin"].toString()))}",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                sb5,
                                                Row(
                                                  children: [
                                                    Text("Denda: "),
                                                    Text(
                                                      "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(detail[index]["denda"].toString()))}",
                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Text("Total: "),
                                                Text(
                                                  "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(detail[index]["total"].toString()))}",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (status == 1)
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            print("bayar");
                            await IakpostpaidProvider().setPayment(data["tr_id"], data["ref_id"]).then((value) {
                              print(value.body);
                              if (value.body["code"] == 400) {
                                Get.defaultDialog(title: "Gagal", content: Text(value.body["data"]["message"]));
                              } else {
                                Get.offNamed(Routes.TRANSACTIONS, arguments: {"refresh": true});
                              }
                            }).catchError(
                              (err) => {print(err)},
                            );
                          },
                          style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(30, 60))),
                          child: Text("Bayar Sekarang"),
                        ),
                      ),
                    Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
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
          ],
        ),
      ),
    );
  }
}
