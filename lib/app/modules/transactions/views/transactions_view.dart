import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/data/transaction_provider.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/transactions_controller.dart';
import '../../widgets/trx_status.dart';

import './widgets/trx_topup.dart';
import './widgets/trx_withdraw.dart';
import './widgets/trx_transfer.dart';
import './widgets/trx_belanja.dart';
import './widgets/trx_cashback.dart';
import './widgets/trx_token.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: DefaultAppBar(
            pageTitle: "Transaksi",
          ),
        ),
        body: Column(
          children: [
            sb15,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(children: [
                  FilterJenis(
                    active: true,
                    title: "Semua",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterJenis(
                    active: false,
                    title: "Berlangsung",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterJenis(
                    active: false,
                    title: "Saldo",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterJenis(
                    active: false,
                    title: "Cashback",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterJenis(
                    active: false,
                    title: "Belanja",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FilterJenis(
                    active: false,
                    title: "Selesai",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ]),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Rentang: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(children: [
                        FilterJenis(
                          active: true,
                          title: "1 bulan",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FilterJenis(
                          active: false,
                          title: "6 bulan",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FilterJenis(
                          active: false,
                          title: "1 tahun",
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            sb15,
            Expanded(
              child: RefreshIndicator(
                child: Obx(
                  () => controller.transactions.isEmpty
                      ? controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ListView(
                              children: [Text("Transaksi kosong")],
                            )
                      : StickyGroupedListView(
                          elements: controller.transactions.value,
                          itemComparator: (dynamic a, dynamic b) {
                            return double.parse(
                                        (a["createdAt"]["_seconds"] * 1000 +
                                                a["createdAt"]["_nanoseconds"] /
                                                    1000000)
                                            .toString())
                                    .round() -
                                double.parse((b["createdAt"]["_seconds"] *
                                                1000 +
                                            b["createdAt"]["_nanoseconds"] /
                                                1000000)
                                        .toString())
                                    .round();
                          },
                          groupBy: (dynamic element) {
                            return Timestamp.fromMillisecondsSinceEpoch(
                                    element['createdAt']['_seconds'] * 1000)
                                .toDate()
                                .toString()
                                .substring(0, 10);
                          },
                          itemBuilder: (BuildContext context, dynamic element) {
                            Widget item;

                            print(Timestamp.fromMillisecondsSinceEpoch(
                                    element["createdAt"]["_seconds"] * 1000)
                                .toDate());

                            switch (element['type']) {
                              case 'topup':
                                var history = element['history'];
                                item = ItemTransaksiTopup(
                                  nominal: element['nominal'],
                                  method: element['method'],
                                  code: element['history'][history.length - 1]
                                      ['code'],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              case 'withdraw':
                                var history = element['history'];
                                item = ItemTransaksiWithdrawal(
                                  nominal: element['nominal'],
                                  method: element['method'],
                                  code: element['history'][history.length - 1]
                                      ['code'],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              case 'transfer-in':
                                item = ItemTransaksiTransferIn(
                                  nominal: element['nominal'],
                                  sender: element['senderData']['name'],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              case 'transfer-out':
                                item = ItemTransaksiTransferOut(
                                  nominal: element['nominal'],
                                  recipient: element['recipientData']['name'],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              case 'ref':
                                item = ItemTransaksiCashback(
                                  nominal: element['nominal'],
                                  isCount: element['isCount'],
                                  type: element['type'],
                                  message: element['message'],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              case 'plan-a':
                                item = ItemTransaksiCashback(
                                  nominal: element['nominal'],
                                  isCount: element['isCount'],
                                  type: element['type'],
                                  message: element['message'],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              case 'token':
                                item = ItemTransaksiToken(
                                  nominal: element["tokenPrice"],
                                  tokenCode: element["tokenCode"],
                                  createdAt:
                                      Timestamp.fromMillisecondsSinceEpoch(
                                          element['createdAt']['_seconds'] *
                                              1000),
                                );
                                break;
                              default:
                                item = ItemTransaksiBelanja();
                            }

                            return item;
                          },
                          groupSeparatorBuilder: (dynamic element) {
                            return DateTime.now().toString().substring(0, 10) ==
                                    Timestamp.fromMillisecondsSinceEpoch(
                                            element['createdAt']['_seconds'] *
                                                1000)
                                        .toDate()
                                        .toString()
                                        .substring(0, 10)
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Hari ini",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      Timestamp.fromMillisecondsSinceEpoch(
                                              element['createdAt']['_seconds'] *
                                                  1000)
                                          .toDate()
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                          },
                          order: StickyGroupedListOrder.DESC,
                        ),
                ),
                // child: ListView(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(bottom: 15),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 15),
                //             child: PanelTitle(title: "Hari ini"),
                //           ),
                //           sb15,
                //           ItemTransaksiBelanja(),
                //           ItemTransaksiWithdrawal(),
                //           // ItemTransaksiTopup(),
                //           ItemTransaksiTransfer(),
                //         ],
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(bottom: 15),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 15),
                //             child: PanelTitle(title: "Kemarin"),
                //           ),
                //           sb15,
                //           ItemTransaksiCashback(),
                //           ItemTransaksiToken(),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                onRefresh: () {
                  return TransactionProvider()
                      .getUserTransactions()
                      .then((value) {
                    print("refresh");
                    controller.getUserTransactions();
                  });
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNav(
          context: context,
          menu1: false,
          menu2: false,
          menu3: false,
          menu4: true,
        ),
      ),
    );
  }
}

class FilterJenis extends StatelessWidget {
  const FilterJenis({Key? key, required this.active, required this.title})
      : super(key: key);

  final bool active;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(
              color: active ? Color(0xFFFF9800) : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(15.0),
          )),
          backgroundColor: active
              ? MaterialStateProperty.all(Color(0xFFFFD89E))
              : MaterialStateProperty.all(Color(0xFFE4E4E4))),
    );
  }
}
