// ignore_for_file: invalid_use_of_protected_member

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/models/Member.dart';
import 'package:kobermart_client/app/models/Tokens.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/tokenlist_controller.dart';

class TokenlistView extends GetView<TokenlistController> {
  const TokenlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Tokens> getTokens(String keyword) {
      return controller.datalist.value
          .where((e) =>
              e.tokenUsed == false &&
              (e.upline.toString().toLowerCase().contains(controller.keyword.value.toLowerCase()) ||
                  e.tokenReg.toString().toLowerCase().contains(controller.keyword.value.toLowerCase())))
          .toList();
    }

    List<Member> getRegisteredTokens(String keyword) {
      return controller.registeredDataList.value
          .where((e) =>
              e.tokenUsed == true &&
              (e.tokenCode.toString().toLowerCase().contains(controller.keyword.value.toLowerCase()) ||
                  e.upline.toString().toLowerCase().contains(controller.keyword.value.toLowerCase())))
          .toList();
    }

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
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(Duration(seconds: 5), () {}),
                child: Obx(
                  () => controller.datalist.isEmpty
                      ? Center(
                          child: Text("Token Kosong"),
                        )
                      : (controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: PanelTitle(title: "Token"),
                                  ),
                                ),
                                sb10,
                                Obx(() => getTokens(controller.keyword.value).isEmpty
                                    ? Center(child: Text("Kosong"))
                                    : Column(
                                        children: List.generate(
                                          getTokens(controller.keyword.value).length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Card(
                                              elevation: 1,
                                              child: ListTile(
                                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                                onTap: () async {
                                                  if (!(getTokens(controller.keyword.value))[index].opened) {
                                                    await FirebaseFirestore.instance
                                                        .collection("members")
                                                        .doc((getTokens(controller.keyword.value))[index].tokenCode)
                                                        .set({"opened": true}, SetOptions(merge: true));
                                                    Get.toNamed(Routes.TOKENDETAIL, arguments: {"data": (getTokens(controller.keyword.value))[index]});
                                                  } else {
                                                    Get.toNamed(
                                                      Routes.TOKENDETAIL,
                                                      arguments: {"data": (getTokens(controller.keyword.value))[index]},
                                                    );
                                                  }
                                                },
                                                leading: Badge(
                                                  badgeColor: Colors.amber,
                                                  showBadge: !(getTokens(controller.keyword.value))[index].opened ? true : false,
                                                  padding: EdgeInsets.all(8),
                                                  child: CircleAvatar(
                                                    child: Text(
                                                      "token",
                                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                    ),
                                                    backgroundColor: Colors.grey.shade200,
                                                    // backgroundImage: AssetImage(
                                                    //     "assets/images/user-placeholder.png"),
                                                  ),
                                                ),
                                                title: Text(
                                                  (getTokens(controller.keyword.value))[index].tokenReg,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: !(getTokens(controller.keyword.value))[index].opened ? FontWeight.bold : FontWeight.normal),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Text("16 Juni 2022 13.45 WITA"),
                                                    Text("Upline: ${(getTokens(controller.keyword.value))[index].uplineData["name"]}"),
                                                  ],
                                                ),
                                                trailing: ItemMenu(
                                                  tokenCode: getTokens(controller.keyword.value)[index].tokenReg,
                                                  tokenUsed: getTokens(controller.keyword.value)[index].tokenUsed,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                sb15,
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: PanelTitle(title: "Telah digunakan"),
                                  ),
                                ),
                                sb10,
                                Obx(() => getRegisteredTokens(controller.keyword.value).isEmpty
                                    ? Center(child: Text("Kosong"))
                                    : Column(
                                        children: List.generate(
                                          getRegisteredTokens(controller.keyword.value).length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Card(
                                              elevation: 1,
                                              child: ListTile(
                                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                                onTap: () {
                                                  Get.toNamed(Routes.MEMBERPROFILE, arguments: {
                                                    "name": getRegisteredTokens(controller.keyword.value)[index].name,
                                                    "id": getRegisteredTokens(controller.keyword.value)[index].id
                                                  });
                                                },
                                                leading: Badge(
                                                  badgeColor: Colors.amber,
                                                  showBadge: false,
                                                  padding: EdgeInsets.all(8),
                                                  child: CircleAvatar(
                                                    child: Icon(Icons.person),
                                                    // backgroundImage:
                                                    //     CachedNetworkImageProvider(
                                                    //         "https://i.pravatar.cc/150?img=${index + 10}"),
                                                  ),
                                                ),
                                                title: Text(
                                                  getRegisteredTokens(controller.keyword.value)[index].name,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Text("16 Juni 2022 13.45 WITA"),
                                                    Text("Upline: ${getRegisteredTokens(controller.keyword.value)[index].uplineData["name"]}"),
                                                  ],
                                                ),
                                                trailing: ItemMenu(
                                                  tokenCode: getRegisteredTokens(controller.keyword.value)[index].tokenCode,
                                                  tokenUsed: getRegisteredTokens(controller.keyword.value)[index].tokenUsed,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                              ],
                            )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  ItemMenu({Key? key, required this.tokenCode, required this.tokenUsed}) : super(key: key);

  final String tokenCode;
  final bool tokenUsed;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded),
      padding: EdgeInsets.zero,
      onSelected: (value) => print(value),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          onTap: () {
            Clipboard.setData(ClipboardData(text: tokenCode)).then((value) => Get.snackbar("Berhasil", "Token berhasil disalin"));
          },
          value: "salin",
          child: ListTile(
            leading: const Icon(Icons.copy),
            title: Text(
              "Salin Token",
            ),
          ),
        ),
        if (!tokenUsed)
          PopupMenuItem<String>(
            value: "register",
            enabled: !tokenUsed,
            child: ListTile(
              leading: const Icon(Icons.person_add),
              title: Text(
                "Isi data",
              ),
            ),
          ),
        if (!tokenUsed) const PopupMenuDivider(),
        if (!tokenUsed)
          PopupMenuItem<String>(
            value: "hapus",
            enabled: !tokenUsed,
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
  CariButton({
    Key? key,
  }) : super(key: key);

  final tokenlistC = Get.find<TokenlistController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 30,
      child: TextField(
        controller: tokenlistC.searchC,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFE4E4E4),
            hintText: "Cari upline atau anggota",
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
            contentPadding: EdgeInsets.only(left: 2, right: 2, bottom: 3, top: 3)),
        onChanged: (value) {
          tokenlistC.keyword.value = value.toString();
        },
      ),
    );
  }
}
