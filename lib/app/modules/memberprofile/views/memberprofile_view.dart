import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import 'package:username_gen/username_gen.dart';

import '../controllers/memberprofile_controller.dart';

class MemberprofileView extends StatelessWidget {
  final profileC = Get.find<MemberprofileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profil Anggota',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 1,
        ),
        body: ListView(children: [
          Container(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sb20,
                Container(
                  height: Get.width * 0.3,
                  width: Get.width * 0.3,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150?img=12"),
                  ),
                ),
                sb20,
                PanelTitle(
                  title: "Wilson Levin",
                ),
                Text("Bergabung sejak 11-06-2022"),
                sb20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PanelTitle(title: "Anggota"),
                          Text("90 orang"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PanelTitle(title: "Kedalaman"),
                          Text("KD2"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PanelTitle(title: "Status"),
                          Text("Aktif"),
                        ],
                      )
                    ],
                  ),
                ),
                sb15,
                Container(
                  width: Get.width,
                  decoration: Shadow1(),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PanelTitle(title: "Referal ID"),
                          Text(
                            "wilsonlev22",
                            style: TextStyle(fontSize: 18),
                          ),
                          sb15,
                          PanelTitle(title: "Email"),
                          GestureDetector(
                              onTap: () {
                                print("klik");
                              },
                              child: Text(
                                "wilsonlevin@gmail.com",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              )),
                          sb15,
                          PanelTitle(title: "Whatsapp"),
                          GestureDetector(
                              onTap: () {
                                print("klik");
                              },
                              child: Text(
                                "+62 812 432234",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              )),
                          sb15,
                          PanelTitle(title: "Tanggal lahir"),
                          Text(
                            "11 Desemberr 1990",
                            style: TextStyle(fontSize: 18),
                          ),
                          sb15,
                          PanelTitle(title: "Alamat"),
                          Text(
                            "Jalan Raya Sidemen, Kabupaten Bangli, Bali 80552",
                            style: TextStyle(fontSize: 18),
                          ),
                        ]),
                  ),
                ),
                sb15,
                Container(
                  width: Get.width,
                  decoration: Shadow1(),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PanelTitle(title: "Upline"),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
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
                sb15,
                Container(
                  decoration: Shadow1(),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PanelTitle(title: "Buat token disini"),
                              Text("Slot KD1 tersedia: 4")
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text("+ Token")))
                      ],
                    ),
                  ),
                ),
                sb15,
                PanelKedalaman(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class PanelKedalaman extends StatelessWidget {
  final memberC = Get.find<MemberprofileController>();

  @override
  Widget build(BuildContext context) {
    var username = UsernameGen().generate();
    return Obx(
      () => ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          memberC.kd[panelIndex].isExpanded.value = !isExpanded;
        },
        animationDuration: Duration(milliseconds: 500),
        children: memberC.kd
            .map<ExpansionPanel>(
              (DaftarKedalaman item) => ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Row(children: [
                        Text(
                          "KD ${memberC.kd.indexOf(item) + 1}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.all(0),
                          backgroundColor: Color(0xFFFF9800),
                          label: Text('10 orang',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.all(0),
                          backgroundColor: Colors.blue,
                          label: Text('0 slot',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      ]),
                    );
                  },
                  body: Container(
                    height: 120,
                    width: double.infinity,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            child: Card(
                                shadowColor: Colors.transparent,
                                child: TextButton(
                                  onPressed: () {
                                    Get.offAndToNamed(Routes.MEMBERPROFILE);
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                            "https://i.pravatar.cc/150?img=${memberC.kd.indexOf(item) + index + 10}"),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text(
                                        username,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: [
                                            WidgetSpan(
                                              child:
                                                  Icon(Icons.person, size: 14),
                                            ),
                                            TextSpan(
                                              text: "8",
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                        separatorBuilder: (ctx, int) {
                          return SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: 10),
                  ),
                  isExpanded: item.isExpanded.value),
            )
            .toList(),
      ),
    );
  }
}
