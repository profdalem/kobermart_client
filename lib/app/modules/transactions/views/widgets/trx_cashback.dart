import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/models/Transactions.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/trx_status.dart';

class ItemTransaksiCashback extends StatelessWidget {
  final Transaction data;
  ItemTransaksiCashback({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jenis = "";
    var sumber = "";
    Color? iconColor = Colors.blue;
    int code = 4;

    if (data.status == "FAILED") {
      code = 5;
    }

    switch (data.type) {
      case "referral":
        sumber = data.data["transactionData"]["message"];
        jenis = "Referral";
        break;
      case "plan-a":
        sumber = data.data["transactionData"]["message"];
        jenis = "Plan A";
        iconColor = Colors.red[400];
        break;
      case "plan-b":
        sumber = data.data["transactionData"]["message"];
        jenis = "Plan B";
        iconColor = Colors.orange[400];
        break;
      default:
        sumber = "N/A";
        jenis = "N/A";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_CASHBACK, arguments: {"data": data, "jenis": jenis, "iconColor": iconColor});
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.grey.shade300),
            elevation: MaterialStateProperty.all(1),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: SvgPicture.asset(
                  "assets/icons/icon-cashback.svg",
                  color: iconColor,
                  fit: BoxFit.scaleDown,
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
                            "${jenis}",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        "+ Rp ${NumberFormat("#,##0", "id_ID").format(data.nominal)}",
                        style: TextStyle(color: Colors.green.shade300, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width * 0.1,
                                child: Text(
                                  "${DateFormat.Hm().format(data.createdAt)}",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  sumber,
                                  style: TextStyle(color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
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
