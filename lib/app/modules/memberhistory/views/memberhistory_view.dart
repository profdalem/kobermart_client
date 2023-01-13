import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../controllers/memberhistory_controller.dart';

class MemberhistoryView extends GetView<MemberhistoryController> {
  MemberhistoryView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
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
              child: StickyGroupedListView(
            elements: authC.sortedMemberList(controller.keyword.value),
            groupBy: (dynamic element) => Timestamp.fromMillisecondsSinceEpoch(element["createdAt"]).toDate().toLocal().toString().substring(0, 10),
            itemComparator: (dynamic a, dynamic b) =>
                a["createdAt"] - b["createdAt"],
            order: StickyGroupedListOrder.DESC,
            groupSeparatorBuilder: (dynamic element) {
              return DateTime.now().toString().substring(0, 10) == Timestamp.fromMillisecondsSinceEpoch(element["createdAt"]).toDate().toLocal().toString().substring(0, 10)
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Hari ini", style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Timestamp.fromMillisecondsSinceEpoch(element["createdAt"]).toDate().toLocal().toString().substring(0, 10),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
            },
            itemBuilder: (BuildContext context, dynamic element) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(Routes.MEMBERPROFILE, arguments: {"id": element["id"], "name": element["name"]});
                    },
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(element['imgurl']),
                    ),
                    title: PanelTitle(title: element['name'] != null ? element['name'] : element['id']),
                    subtitle: Text("${DateFormat.Hm().format(Timestamp.fromMillisecondsSinceEpoch(element["createdAt"]).toDate())} - ${element['uplineName']}"),
                  ),
                ),
              );
            },
          )
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
  CariButton({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<MemberhistoryController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 30,
      child: TextField(
        controller: controller.searchC,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFE4E4E4),
            hintText: "Cari anggota",
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
                gapPadding: 0, borderSide: BorderSide(color: Color(0xFFE4E4E4), style: BorderStyle.solid), borderRadius: BorderRadius.all(Radius.circular(25))),
            enabledBorder: OutlineInputBorder(
                gapPadding: 0, borderSide: BorderSide(color: Color(0xFFE4E4E4), style: BorderStyle.solid), borderRadius: BorderRadius.all(Radius.circular(25))),
            contentPadding: EdgeInsets.only(left: 16, right: 2, bottom: 3, top: 3)),
        onChanged: (value) {
          controller.keyword.value = value.toString();
        },
      ),
    );
  }
}

void openProfile() {
  Get.toNamed(Routes.MEMBERPROFILE);
}
