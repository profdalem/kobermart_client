import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/transactions_controller.dart';
import '../../widgets/trx_status.dart';

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
                child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: PanelTitle(title: "Hari ini"),
                      ),
                      sb15,
                      ItemTransaksiBelanja(),
                      ItemTransaksiWithdrawal(),
                      ItemTransaksiTopup(),
                      ItemTransaksiTransfer(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: PanelTitle(title: "Kemarin"),
                      ),
                      sb15,
                      ItemTransaksiCashback(),
                      ItemTransaksiToken(),
                    ],
                  ),
                )
              ],
            ))
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

class ItemTransaksiTopup extends StatelessWidget {
  const ItemTransaksiTopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TOPUP);
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
                  "assets/icons/icon-topup.svg",
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
                            "Top Up",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                                    fontSize: 20),
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
                                "Cash (COD)",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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

class ItemTransaksiWithdrawal extends StatelessWidget {
  const ItemTransaksiWithdrawal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_WITHDRAWAL);
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                                    fontSize: 20),
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
                                "Transfer Bank",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
                            "Transfer",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                                    fontSize: 20),
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
                                    color: Colors.black, fontSize: 16),
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

class ItemTransaksiCashback extends StatelessWidget {
  const ItemTransaksiCashback({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jenis = "Referral";
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_CASHBACK);
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
                  "assets/icons/icon-cashback.svg",
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
                            "Cashback (${jenis})",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                                "Rp 40.000",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Sumber:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "Generate Token",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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

class ItemTransaksiToken extends StatelessWidget {
  const ItemTransaksiToken({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_TOKEN);
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                                "Rp 200.000",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
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
                                    color: Colors.black, fontSize: 16),
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

class ItemTransaksiBelanja extends StatelessWidget {
  const ItemTransaksiBelanja({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.TRXDETAIL_SHOP, arguments: {"nominal": 201});
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
                  "assets/icons/icon-belanja.svg",
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
                            "Belanja",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                  Text(
                    "Kopi Sachet 3in1 Instant Coffee Mocca ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "+2 produk lain",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  sb15,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total belanja:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "Rp 450.000",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
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
                                "Potong Saldo",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
              style: TextStyle(color: Colors.black),
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
