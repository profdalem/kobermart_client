import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/models/Transactions.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/trx_status.dart';

class ItemTransaksiWithdrawal extends StatelessWidget {
  final Transaction data;
  ItemTransaksiWithdrawal({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var createdAt = data.createdAt;
    var code = data.getStatus();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_WITHDRAWAL, arguments: {"data": data});
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
                  "assets/icons/icon-withdrawal.svg",
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
                            "Withdrawal",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "${DateFormat.Hm().format(createdAt)}",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                          "- Rp ${NumberFormat("#,##0", "id_ID").format(data.nominal)}",
                          style: TextStyle(color: code == 4 ? Colors.red.shade400 : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 14),
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
