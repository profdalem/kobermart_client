import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/tokendetail_controller.dart';

class TokendetailView extends GetView<TokendetailController> {
  const TokendetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                    "828929348357",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        print("klik");
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
                                "Amanda Curtis",
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
                                "16 Juni 2022 13.45 WITA",
                                style: TextStyle(fontSize: 18),
                              )),
                          sb15,
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTRATION);
                                },
                                child: Text("Isi Data Anggota")),
                          )
                        ]),
                  ),
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
                          PanelTitle(title: "Upline"),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  "https://i.pravatar.cc/150?img=18"),
                            ),
                            title: Text("Robert Xemeckis"),
                            onTap: () {
                              print("liht anggota");
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
