import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/tokendetail_controller.dart';

class TokendetailView extends GetView<TokendetailController> {
  TokendetailView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    String tokenCode = "-";
    String creator = "tidak ditemukan";
    Timestamp createdAt = Timestamp.now();

    if (Get.arguments != null) {
      tokenCode = Get.arguments["data"]["memberData"]["tokenCode"];
      creator = Get.arguments["data"]["memberData"]["tokenCreator"];
      createdAt = Timestamp(
          Get.arguments["data"]["memberData"]["tokenCreatedAt"]["_seconds"],
          Get.arguments["data"]["memberData"]["tokenCreatedAt"]
              ["_nanoseconds"]);
    }

    return Scaffold(
        backgroundColor: Color(0xFFF4F4F4),
        appBar: AppBar(
          title: const Text(
            'Detail Token',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 15),
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/icon-token.svg",
                  width: Get.width * 0.2,
                ),
                sb15,
                Container(
                  width: Get.width,
                  decoration: Shadow1(),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PanelTitle(title: "Token"),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    tokenCode,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(text: tokenCode),
                                        ).then((value) => Get.snackbar(
                                            "Berhasil",
                                            "Token berhasil disalin"));
                                      },
                                      child: Text(
                                        "Salin",
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          sb15,
                          PanelTitle(title: "Dibuat oleh"),
                          GestureDetector(
                              onTap: () {
                                print("klik");
                              },
                              child: Text(
                                creator,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              )),
                          sb15,
                          PanelTitle(title: "Dibuat pada"),
                          GestureDetector(
                              onTap: () {
                                print("klik");
                              },
                              child: Text(
                                "${DateFormat.yMMMd("id_ID").format(createdAt.toDate())} ${DateFormat.Hm().format(createdAt.toDate())} WITA",
                                style: TextStyle(fontSize: 18),
                              )),
                          sb15,
                          if (creator == homeC.id.value ||
                              Get.arguments["data"]["upline"] == homeC.id.value)
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.REGISTRATION,
                                        arguments: {"tokenCode": tokenCode});
                                  },
                                  child: Text("Isi Data Anggota")),
                            )
                        ]),
                  ),
                ),
                sb15,
                if (Get.arguments != null)
                  Container(
                    width: Get.width,
                    decoration: Shadow1(),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PanelTitle(title: "Upline"),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                                // backgroundImage: CachedNetworkImageProvider(
                                //     "https://i.pravatar.cc/150?img=18"),
                              ),
                              title: Text(
                                  Get.arguments["data"]["uplineData"]["name"]),
                              onTap: () {
                                print("lihat anggota");
                              },
                            )
                          ]),
                    ),
                  ),
              ],
            )
          ],
        ));
  }
}
