import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import 'package:username_gen/username_gen.dart';

import '../controllers/tokenlist_controller.dart';

class TokenlistView extends GetView<TokenlistController> {
  const TokenlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Token'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  CariButton(),
                ],
              ),
            ),
            sb15,
            Expanded(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: PanelTitle(title: "Token"),
                    ),
                  ),
                  sb10,
                  Column(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: Shadow1(),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            onTap: () {
                              Get.toNamed(Routes.TOKENDETAIL);
                            },
                            leading: Badge(
                              badgeColor: Colors.amber,
                              showBadge: index == 0 ? true : false,
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/user-placeholder.png")),
                            ),
                            title: Text(
                              "8712397917412",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: index == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("16 Juni 2022 13.45 WITA"),
                                Text("Upline: Margor Robbie"),
                              ],
                            ),
                            trailing: ItemMenu(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sb15,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: PanelTitle(title: "Telah digunakan"),
                    ),
                  ),
                  sb10,
                  Column(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: Shadow1(),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            onTap: () {
                              Get.toNamed(Routes.TOKENDETAIL);
                            },
                            leading: Badge(
                              badgeColor: Colors.amber,
                              showBadge: false,
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/150?img=${index + 10}"),
                              ),
                            ),
                            title: Text(
                              UsernameGen().generate(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("16 Juni 2022 13.45 WITA"),
                                Text("Upline: Margor Robbie"),
                              ],
                            ),
                            trailing: ItemMenu(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded),
      padding: EdgeInsets.zero,
      onSelected: (value) => print(value),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "salin",
          child: ListTile(
            leading: const Icon(Icons.copy),
            title: Text(
              "Salin Token",
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: "register",
          child: ListTile(
            leading: const Icon(Icons.person_add),
            title: Text(
              "Isi data",
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: "hapus",
          child: ListTile(
            iconColor: Colors.red.shade400,
            textColor: Colors.red.shade400,
            leading: const Icon(Icons.delete),
            title: Text(
              "Hapus",
            ),
          ),
        ),
      ],
    );
  }
}

class CariButton extends StatelessWidget {
  const CariButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 30,
      child: TextButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cari token atau upline",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.search,
                color: Colors.black,
              )
            ],
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            )),
            backgroundColor: MaterialStateProperty.all(Color(0xFFE4E4E4))),
      ),
    );
  }
}
