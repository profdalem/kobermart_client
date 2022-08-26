import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kobermart_client/app/controllers/product_controller.dart';

import '../../routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

class DefaultAppBar extends StatelessWidget {
  DefaultAppBar({Key? key, required this.pageTitle}) : super(key: key);

  final String pageTitle;
  final productC = Get.find<MainProductController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      leadingWidth: MediaQuery.of(context).size.width * 0.1,
      leading: pageTitle == "home"
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SvgPicture.asset(
                "assets/logo/kobermart-logo-white.svg",
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
              ),
            ),
      title: pageTitle == "home"
          ? SvgPicture.asset(
              "assets/logo/kobermart-logo-long.svg",
              width: MediaQuery.of(context).size.width * 0.35,
              alignment: Alignment.bottomLeft,
            )
          : Text(pageTitle),
      actions: [
        IconButton(
            onPressed: () {
              productC.getAllProduct();
              productC.getAllCarts();
              print(productC.carts[0]);
            },
            icon: Icon(Icons.refresh)),
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
            icon: Badge(
              badgeContent: Text(
                '3',
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Color(0xFFE49542),
              child: Icon(Icons.notifications),
            )),
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.CART);
            },
            icon: Badge(
              badgeContent: Text(
                '10',
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Color(0xFFE49542),
              child: Icon(Icons.shopping_cart),
            )),
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.MENU);
            },
            icon: Icon(Icons.menu_rounded)),
      ],
    );
  }
}
