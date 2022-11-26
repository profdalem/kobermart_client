// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/data/transaction_provider.dart';
import 'package:kobermart_client/app/modules/transactions/views/widgets/trx_prepaid.dart';
import 'package:kobermart_client/style.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/transactions_controller.dart';

import './widgets/trx_topup.dart';
import './widgets/trx_withdraw.dart';
import './widgets/trx_transfer.dart';
import './widgets/trx_belanja.dart';
import './widgets/trx_cashback.dart';
import './widgets/trx_token.dart';
import './widgets/trx_postpaid.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      print(Get.arguments["refresh"]);
      if (Get.arguments["refresh"] == true) {
        print("Arguments refresh is true");
        Future.delayed(Duration(milliseconds: 500), () => controller.getUserTransactions());
      }
    }
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
                child: Obx(
                  () => controller.filterBy.isNotEmpty
                      ? Row(
                          children: List.generate(
                            controller.filters.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: FilterJenis(
                                code: controller.filters[index]["code"]!,
                                title: controller.filters[index]["name"]!,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
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
                      child: Obx(
                        () => Row(
                          children: [
                            FilterRentang(
                              title: "7 hari",
                              days: 7,
                              selectedDays: controller.days.value,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FilterRentang(
                              title: "30 hari",
                              days: 30,
                              selectedDays: controller.days.value,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FilterRentang(
                              title: "6 bulan",
                              days: 180,
                              selectedDays: controller.days.value,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FilterRentang(
                              title: "1 tahun",
                              days: 365,
                              selectedDays: controller.days.value,
                            ),
                          ],
                        ),
                      ),
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
                          elements: controller.filteredTransaction(controller.filterBy.value),
                          itemComparator: (dynamic a, dynamic b) {
                            return double.parse((a["createdAt"]["_seconds"] * 1000 + a["createdAt"]["_nanoseconds"] / 1000000).toString()).round() -
                                double.parse((b["createdAt"]["_seconds"] * 1000 + b["createdAt"]["_nanoseconds"] / 1000000).toString()).round();
                          },
                          groupBy: (dynamic element) {
                            return Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000).toDate().toString().substring(0, 10);
                          },
                          itemBuilder: (BuildContext context, dynamic element) {
                            Widget item;

                            switch (element['type']) {
                              case 'topup':
                                var history = element['history'];
                                item = ItemTransaksiTopup(
                                  nominal: element['nominal'],
                                  method: element['method'],
                                  code: element['history'][history.length - 1]['code'],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'withdraw':
                                var history = element['history'];
                                item = ItemTransaksiWithdrawal(
                                  nominal: element['nominal'],
                                  method: element['method'],
                                  code: element['history'][history.length - 1]['code'],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'transfer-in':
                                item = ItemTransaksiTransferIn(
                                  nominal: element['nominal'],
                                  sender: element['senderData']['name'],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'transfer-out':
                                item = ItemTransaksiTransferOut(
                                  nominal: element['nominal'],
                                  recipient: element['recipientData']['name'],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'ref':
                                item = ItemTransaksiCashback(
                                  nominal: element['nominal'],
                                  isCount: element['isCount'],
                                  type: element['type'],
                                  message: element['message'],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'plan-a':
                                item = ItemTransaksiCashback(
                                  nominal: element['nominal'],
                                  isCount: element['isCount'],
                                  type: element['type'],
                                  message: element['message'],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'token':
                                item = ItemTransaksiToken(
                                  nominal: element["tokenPrice"],
                                  tokenCode: element["tokenCode"],
                                  createdAt: Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000),
                                );
                                break;
                              case 'prepaid':
                                item = ItemTransaksiPrepaid(data: element);
                                break;
                              case 'postpaid':
                                item = ItemTransaksiPostpaid(
                                  data: element,
                                );
                                break;
                              default:
                                item = ItemTransaksiBelanja();
                            }

                            return item;
                          },
                          groupSeparatorBuilder: (dynamic element) {
                            return DateTime.now().toString().substring(0, 10) ==
                                    Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000).toDate().toString().substring(0, 10)
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Hari ini", style: TextStyle(fontWeight: FontWeight.bold)),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      Timestamp.fromMillisecondsSinceEpoch(element['createdAt']['_seconds'] * 1000)
                                          .toDate()
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                  return TransactionProvider().getUserTransactions(controller.days.value).then((value) {
                    print("refresh");
                    controller.transactions.value = value.body;
                    controller.transactions.refresh();
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

class FilterRentang extends StatelessWidget {
  FilterRentang({Key? key, required this.title, required this.days, required this.selectedDays}) : super(key: key);

  final String title;
  final int days;
  final int selectedDays;
  final transactionC = Get.find<TransactionsController>();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (transactionC.days.value != days) {
          transactionC.days.value = days;
          transactionC.getUserTransactions();
        }
      },
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
              color: transactionC.days.value == days ? Color(0xFFFF9800) : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(15.0),
          )),
          backgroundColor:
              transactionC.days.value == days ? MaterialStateProperty.all(Color(0xFFFFD89E)) : MaterialStateProperty.all(Color(0xFFE4E4E4))),
    );
  }
}

class FilterJenis extends StatelessWidget {
  FilterJenis({Key? key, required this.code, required this.title}) : super(key: key);

  final String code;
  final String title;
  final transactionC = Get.find<TransactionsController>();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (transactionC.filterBy.value != code) {
          transactionC.filterBy.value = code;
          transactionC.getUserTransactions();
        }
      },
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
              color: transactionC.filterBy.value == code ? Color(0xFFFF9800) : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(15.0),
          )),
          backgroundColor:
              transactionC.filterBy.value == code ? MaterialStateProperty.all(Color(0xFFFFD89E)) : MaterialStateProperty.all(Color(0xFFE4E4E4))),
    );
  }
}
