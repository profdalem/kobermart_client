import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import 'package:username_gen/username_gen.dart';

import '../controllers/memberhistory_controller.dart';

class MemberhistoryView extends GetView<MemberhistoryController> {
  const MemberhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Gabung'),
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
                    child: PanelTitle(title: "Hari ini"),
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          onTap: () {
                            openProfile();
                          },
                          leading: Badge(
                            badgeColor: Colors.amber,
                            showBadge: false,
                            padding: EdgeInsets.all(8),
                            child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/150?img=${index + 10}")),
                          ),
                          title: Text(
                            UsernameGen().generate(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text("12.45 WITA"),
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
                    child: PanelTitle(title: "20 Juni 2022"),
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          onTap: () {
                            openProfile();
                          },
                          leading: Badge(
                            badgeColor: Colors.amber,
                            showBadge: false,
                            padding: EdgeInsets.all(8),
                            child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/150?img=${index + 15}")),
                          ),
                          title: Text(
                            UsernameGen().generate(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text("12.45 WITA"),
                          trailing: ItemMenu(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          sb15,
        ],
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
          value: "lihat",
          child: ListTile(
            leading: const Icon(Icons.remove_red_eye),
            title: Text(
              "Lihat",
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: "transfer",
          child: ListTile(
            leading: const Icon(Icons.send),
            title: Text(
              "Transfer Dana",
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
                "Cari anggota",
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

void openProfile() {
  Get.toNamed(Routes.MEMBERPROFILE);
}
