import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/models/Transactions.dart';

import '../../../../routes/app_pages.dart';

class ItemTransaksiTransfer extends StatelessWidget {
  final Transaction data;
  const ItemTransaksiTransfer({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "Transfer";
    String text1 = "";
    String text2 = "";
    Color color = Colors.red.shade400;
    switch (data.type) {
      case "transfer-out":
        text1 = "Tujuan ";
        text2 = data.data["customerData"]["recipientName"];
        break;
      case "transfer-in":
        title = "Dana masuk";
        text1 = "Pengirim ";
        text2 = data.data["customerData"]["senderName"];
        color = Colors.green.shade300;
        break;
      default:
    }

    if (text2.isNotEmpty) {
      var temp = text2.split(" ");
      var result = [];
      for (var i = 0; i < temp[0].length; i++) {
        if (i < (temp[0].length / 2).floor()) {
          result.add(temp[0][i]);
        } else {
          result.add("*");
        }
      }
      text2 = result.join();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TRANSFER, arguments: {"data": data});
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.grey),
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
                  "assets/icons/icon-transfer.svg",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "- Rp ${NumberFormat("#,##0", "id_ID").format(data.nominal)}",
                            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
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
                              text1 + " " + text2,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
