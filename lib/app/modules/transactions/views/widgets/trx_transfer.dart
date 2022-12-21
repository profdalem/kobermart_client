import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/trx_status.dart';

class ItemTransaksiTransfer extends StatelessWidget {
  const ItemTransaksiTransfer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TRANSFER);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transfer",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "12.21 - 12 Sep 2021",
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
                                "Rp 450.000",
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
                                "Tujuan:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "Nama User",
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

class ItemTransaksiTransferOut extends StatelessWidget {
  final int nominal;
  final String recipient;
  final Timestamp createdAt;
  const ItemTransaksiTransferOut({
    Key? key,
    required this.nominal,
    required this.recipient,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TRANSFER);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transfer (keluar)",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "${DateFormat.Hm().format(createdAt.toDate().add(Duration(hours: 8)))} WITA",
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
                                "Tujuan:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                recipient,
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

class ItemTransaksiTransferIn extends StatelessWidget {
  final int nominal;
  final String sender;
  final Timestamp createdAt;
  const ItemTransaksiTransferIn({
    Key? key,
    required this.nominal,
    required this.sender,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TRANSFER);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transfer (masuk)",
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
                                "Pengirim:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                sender,
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
