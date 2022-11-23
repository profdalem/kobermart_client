import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../style.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/trx_status.dart';

class ItemTransaksiPrepaid extends StatelessWidget {
  ItemTransaksiPrepaid({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    var createdAt = Timestamp.fromMillisecondsSinceEpoch(
        data['createdAt']['_seconds'] * 1000);
    var nominal = data["nominal"];
    var status = 2;
    var product = "Product";
    var icon = "https://cdn.mobilepulsa.net/img/logo/pulsa/small/listrik.png";

    switch (data["data"]["transactionData"]["rc"]) {
      case "00":
        status = 4;
        break;
      default:
        status = 2;
    }

    switch (
        data["data"]["transactionData"]["ref_id"].toString().substring(0, 6)) {
      case 'PREPLN':
        product = "Token Listrik";
        icon = data["data"]["productData"]["icon_url"];
        break;
      default:
        product = "Product";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_PREPAID, arguments: {"data": data});
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.grey),
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: CachedNetworkImage(
                    imageUrl: icon,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text(
                              "${DateFormat.Hm().format(createdAt.toDate())} WITA",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
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
                    SizedBox(
                      height: 5,
                    ),
                    status == 4 && product == "Token Listrik"
                        ? Column(
                            children: [
                              Text(
                                "SN: ${data["data"]["transactionData"]["sn"].toString().split("/")[0]}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              sb10,
                            ],
                          )
                        : SizedBox(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Harga:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "Rp ${NumberFormat("#,##0", "id_ID").format(int.parse(nominal.toString()))}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Metode:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "Potong Saldo",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}