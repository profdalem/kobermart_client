import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../style.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/trx_status.dart';

class ItemTransaksiPostpaid extends StatelessWidget {
  ItemTransaksiPostpaid({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    print(data);
    String logo = "assets/icons/logo_pln.svg";
    String product = "";
    String name = "";

    String meterNo = "";

    int nominal = data["nominal"];
    int status = 1;
    var createdAt = Timestamp.fromMillisecondsSinceEpoch(data["createdAt"]["_seconds"] * 1000);

    switch (data["additional"].toString().split("_")[0].toLowerCase()) {
      case "pln":
        logo = "assets/icons/logo_pln.svg";
        product = "Tagihan Listrik";
        name = data["data"]["transactionData"]["tr_name"];
        meterNo = data["data"]["transactionData"]["hp"];
        break;
      default:
        logo = "assets/icons/logo_pln.svg";
        product = "Produk";
    }

    switch (data["data"]["transactionData"]["message"]) {
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_POSTPAID, arguments: {"data": data, "createdAt": createdAt});
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.grey),
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: SvgPicture.asset(
                  logo,
                  height: 30,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Expanded(
              flex: 88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "${DateFormat.Hm().format(createdAt.toDate())} WITA",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      TrxStatus(
                        statusCode: status,
                      ),
                    ],
                  ),
                  Divider(
                    height: 2,
                  ),
                  sb5,
                  Row(
                    children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            "Biaya:",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(nominal.toString()))}",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ]),
                      ),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            meterNo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ]),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
