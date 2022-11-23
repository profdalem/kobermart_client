import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/memberprofile_controller.dart';

class MemberprofileView extends StatelessWidget {
  final profileC = Get.find<MemberprofileController>();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      profileC.getMemberProfile(Get.arguments["id"]);
      print(Get.arguments);
      profileC.name.value = Get.arguments["name"];
    }

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
        body: Obx(() => RefreshIndicator(
              onRefresh: () {
                if (Get.arguments != null) {
                  return profileC.getMemberProfile(Get.arguments["id"]);
                } else {
                  return Future.delayed(Duration(milliseconds: 100));
                }
              },
              child: ListView(children: [
                Container(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sb20,
                      // Profile picture
                      Container(
                        height: Get.width * 0.3,
                        width: Get.width * 0.3,
                        child: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: Get.width * 0.2,
                          ),
                          // backgroundImage: CachedNetworkImageProvider(
                          //     "https://i.pravatar.cc/150?img=12"),
                        ),
                      ),
                      sb20,
                      // Name
                      PanelTitle(
                        title: profileC.name.value,
                      ),
                      // Bundle information
                      profileC.isLoading.value
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: Get.width * 0.2),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    "Bergabung sejak ${DateFormat.yMMMMd("id_ID").format(DateTime.fromMillisecondsSinceEpoch(profileC.memberCreatedAt.value.millisecondsSinceEpoch))}"),
                                sb20,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PanelTitle(title: "Anggota"),
                                          Text(
                                              "${profileC.memberCount.value.toString()} orang"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          PanelTitle(title: "Kedalaman"),
                                          Text(
                                              "KD${profileC.kdstatus.value.toString()}"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          PanelTitle(title: "Status"),
                                          profileC.active.value
                                              ? Text("Aktif")
                                              : Text("Non-aktif"),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PanelTitle(title: "Referal ID"),
                                          Text(
                                            profileC.refid.value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          sb15,
                                          PanelTitle(title: "Email"),
                                          GestureDetector(
                                              onTap: () {
                                                print("klik");
                                              },
                                              child: Text(
                                                profileC.email.value,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 18),
                                              )),
                                          sb15,
                                          PanelTitle(title: "Whatsapp"),
                                          GestureDetector(
                                              onTap: () {
                                                print("klik");
                                              },
                                              child: Text(
                                                profileC.whatsapp.value,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 18),
                                              )),
                                          sb15,
                                          PanelTitle(title: "Tanggal lahir"),
                                          Text(
                                            DateFormat.yMMMMd("id_ID").format(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                    profileC.birthday.value
                                                        .millisecondsSinceEpoch)),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          sb15,
                                          PanelTitle(title: "Alamat"),
                                          Text(
                                            profileC.address.value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          if (profileC.rek.value.isNotEmpty &&
                                              profileC.bank.value.isNotEmpty)
                                            sb15,
                                          if (profileC.rek.value.isNotEmpty &&
                                              profileC.bank.value.isNotEmpty)
                                            PanelTitle(title: "Nomor Rekening"),
                                          if (profileC.rek.value.isNotEmpty &&
                                              profileC.bank.value.isNotEmpty)
                                            Text(
                                              "${profileC.rek.value} (${profileC.bank.value})",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PanelTitle(title: "Upline"),
                                          ListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            leading: CircleAvatar(
                                              child: Icon(Icons.person),
                                              // backgroundImage: CachedNetworkImageProvider(
                                              //     "https://i.pravatar.cc/150?img=18"),
                                            ),
                                            title:
                                                Text(profileC.uplineName.value),
                                            onTap: () {
                                              print("lihat anggota");
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PanelTitle(
                                                  title: "Buat token disini"),
                                              Text(
                                                  "Slot KD1 tersedia: ${(10 - profileC.kd1count.value).toString()}")
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text("+ Token")))
                                      ],
                                    ),
                                  ),
                                ),
                                sb15,
                                PanelKedalaman(
                                  memberC: profileC,
                                ),
                                sb15
                              ],
                            ),
                    ],
                  ),
                )
              ]),
            )),
      ),
    );
  }
}

class PanelKedalaman extends StatelessWidget {
  PanelKedalaman({
    Key? key,
    required this.memberC,
  }) : super(key: key);

  final MemberprofileController memberC;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => memberC.downlines.isEmpty
          ? Center(
              child: Text("Downline Kosong"),
            )
          : ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                memberC.kd[panelIndex].isExpanded.value = !isExpanded;
              },
              animationDuration: Duration(milliseconds: 500),
              children: memberC.kd
                  .map<ExpansionPanel>(
                    (DaftarKedalaman item) => ExpansionPanel(
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) {
                          num slotSize =
                              pow(10, (memberC.kd.indexOf(item) + 1));
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
                                label: Text('${item.members.length} terisi',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.blue,
                                label: Text(
                                    '${slotSize - item.members.length} kosong',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
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
                                var tokenUsed =
                                    item.members[index]["tokenUsed"];
                                return Container(
                                  width: 100,
                                  child: Card(
                                      shadowColor: Colors.transparent,
                                      child: TextButton(
                                        onPressed: () {
                                          if (tokenUsed) {
                                            Get.to(() => MemberprofileView(),
                                                arguments: {
                                                  "id": item.members[index]
                                                      ["id"],
                                                  "name": item.members[index]
                                                      ["memberData"]["name"],
                                                });
                                          } else {
                                            Get.toNamed(Routes.TOKENDETAIL,
                                                arguments: {
                                                  "data": item.members[index]
                                                });
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundColor: tokenUsed
                                                  ? Colors.blue
                                                  : Colors.grey.shade200,
                                              child: tokenUsed
                                                  ? Icon(Icons.person)
                                                  : Text("token"),
                                            ),
                                            Text(
                                              tokenUsed
                                                  ? item.members[index]
                                                      ["memberData"]["name"]
                                                  : (FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid ==
                                                          item.members[index]
                                                                  ["memberData"]
                                                              ["tokenCreator"]
                                                      ? item.members[index]
                                                              ["memberData"]
                                                          ["tokenCode"]
                                                      : "?"),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            if (tokenUsed)
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(Icons.person,
                                                          size: 14),
                                                    ),
                                                    TextSpan(
                                                      text: item.members[index]
                                                              ["kd1count"]
                                                          .toString(),
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
                              itemCount: item.members.length),
                        ),
                        isExpanded: item.isExpanded.value),
                  )
                  .toList(),
            ),
    );
  }
}
