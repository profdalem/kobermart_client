import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/trx_status.dart';

class ItemTransaksiToken extends StatelessWidget {
  final int nominal;
  final Timestamp createdAt;
  final String tokenCode;
  ItemTransaksiToken({
    Key? key,
    required this.nominal,
    required this.createdAt,
    required this.tokenCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TOKEN, arguments: {
            "nominal": nominal,
            "createdAt": createdAt,
            "tokenCode": tokenCode,
          });
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
                  "assets/icons/icon-token.svg",
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
                            "Token",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "${DateFormat.Hm().format(createdAt.toDate())} WITA",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      TrxStatus(
                        statusCode: 4,
                      ),
                    ],
                  ),
                  Divider(
                    height: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jumlah:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "Rp ${NumberFormat("#,##0", "id_ID").format(nominal)}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ]),
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
                                "Potong saldo",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
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