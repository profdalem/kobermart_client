import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/members/views/members_view.dart';
import 'package:kobermart_client/app/modules/transactions/views/transactions_view.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../home/views/home_view.dart';
import '../shop/views/shop_view.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
    required this.context,
    required this.menu1,
    required this.menu2,
    required this.menu3,
    required this.menu4,
  }) : super(key: key);

  final BuildContext context;
  final bool menu1;
  final bool menu2;
  final bool menu3;
  final bool menu4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: Shadow1(),
      child: LayoutBuilder(builder: (context, constraint) {
        return Container(
          height: constraint.maxHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BottomNavItem(
                  active: menu1,
                  logo: "menu-home",
                  title: "Beranda",
                  page: Routes.HOME),
              BottomNavItem(
                active: menu2,
                logo: "menu-shop",
                title: "Belanja",
                page: Routes.SHOP,
              ),
              BottomNavItem(
                  active: menu3,
                  logo: "menu-members",
                  title: "Anggota",
                  page: Routes.MEMBERS),
              BottomNavItem(
                  active: menu4,
                  logo: "menu-trx",
                  title: "Transaksi",
                  page: Routes.TRANSACTIONS),
            ],
          ),
        );
      }),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem(
      {Key? key,
      required this.active,
      required this.logo,
      required this.title,
      required this.page})
      : super(key: key);

  final bool active;
  final String logo;
  final String title;
  final String page;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (!active) {
          Get.toNamed(page);
        }
      },
      style: ButtonStyle(alignment: Alignment.center),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          "assets/logo/${logo}.svg",
          color: active ? Colors.blue : Colors.grey,
          height: MediaQuery.of(context).size.width * 0.05,
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          title,
          style: TextStyle(
              color: active ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 10),
        )
      ]),
    );
  }
}
