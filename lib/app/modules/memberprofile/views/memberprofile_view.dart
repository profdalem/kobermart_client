import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../../../../constants.dart';
import '../controllers/memberprofile_controller.dart';

class MemberprofileView extends StatelessWidget {
  final profileC = Get.find<MemberprofileController>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      profileC.getMemberProfile(Get.arguments["id"]);
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
                          backgroundImage: CachedNetworkImageProvider(PROFILE_IMG),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PanelTitle(title: "Anggota"),
                                          Text("${profileC.memberCount.value.toString()} orang"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          PanelTitle(title: "Kedalaman"),
                                          Text("KD${profileC.kdstatus.value.toString()}"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          PanelTitle(title: "Status"),
                                          profileC.active.value ? Text("Aktif") : Text("Non-aktif"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                sb15,
                                Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                            style: TextStyle(color: Colors.blue, fontSize: 18),
                                          )),
                                      sb15,
                                      PanelTitle(title: "Whatsapp"),
                                      GestureDetector(
                                          onTap: () {
                                            print("klik");
                                          },
                                          child: Text(
                                            profileC.whatsapp.value,
                                            style: TextStyle(color: Colors.blue, fontSize: 18),
                                          )),
                                      sb15,
                                      PanelTitle(title: "Tanggal lahir"),
                                      Text(
                                        DateFormat.yMMMMd("id_ID").format(DateTime.fromMillisecondsSinceEpoch(profileC.birthday.value.millisecondsSinceEpoch)),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      sb15,
                                      PanelTitle(title: "Alamat"),
                                      Text(
                                        profileC.address.value,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      if (profileC.rek.value.isNotEmpty && profileC.bank.value.isNotEmpty) sb15,
                                      if (profileC.rek.value.isNotEmpty && profileC.bank.value.isNotEmpty) PanelTitle(title: "Nomor Rekening"),
                                      if (profileC.rek.value.isNotEmpty && profileC.bank.value.isNotEmpty)
                                        Text(
                                          "${profileC.rek.value} (${profileC.bank.value})",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                    ]),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      PanelTitle(title: "Upline"),
                                      ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        leading: CircleAvatar(
                                          backgroundImage: CachedNetworkImageProvider(PROFILE_IMG),
                                        ),
                                        title: Text(profileC.uplineName.value),
                                        onTap: () {
                                          print("lihat anggota");
                                        },
                                      )
                                    ]),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
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
                                              PanelTitle(title: "Kirim dana"),
                                              Text("Saldo anda: Rp${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}")
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed(Routes.INPUTNUMBER, arguments: {
                                                    "title": TRANSFER,
                                                    "recipient": {
                                                      "name": profileC.name.value,
                                                      "id": Get.arguments["id"],
                                                    }
                                                  });
                                                },
                                                child: Text("Transfer")))
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 1,
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
                                              Text("Slot KD1 tersedia: ${(authC.settings["kd1limit"] - profileC.kd1count.value).toString()}")
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  profileC.generateToken();
                                                },
                                                child: Text("Buat Token")))
                                      ],
                                    ),
                                  ),
                                ),
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
                          num slotSize = pow(10, (memberC.kd.indexOf(item) + 1));
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
                                label: Text('${item.members.length} terisi', style: TextStyle(fontSize: 12, color: Colors.white)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.blue,
                                label: Text('${slotSize - item.members.length} kosong', style: TextStyle(fontSize: 12, color: Colors.white)),
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
                                var tokenUsed = false;
                                if (item.members[index]["type"] == "member") {
                                  tokenUsed = true;
                                }
                                return Container(
                                  width: 100,
                                  child: Card(
                                      shadowColor: Colors.transparent,
                                      child: TextButton(
                                        onPressed: () {
                                          if (tokenUsed) {
                                            Get.to(() => MemberprofileView(), arguments: {
                                              "id": item.members[index]["id"],
                                              "name": item.members[index]["name"],
                                            });
                                          } else {
                                            Get.toNamed(Routes.TOKENDETAIL, arguments: {"data": item.members[index]});
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: CircleAvatar(
                                                    radius: 30.0,
                                                    backgroundColor: tokenUsed ? Colors.transparent : Colors.grey.shade200,
                                                    backgroundImage: tokenUsed ? CachedNetworkImageProvider(PROFILE_IMG) : null,
                                                    child: tokenUsed ? SizedBox() : Text("token"),
                                                  ),
                                                ),
                                                if (tokenUsed)
                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber.shade800,
                                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                                          boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey.shade500)]),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                                            children: [
                                                              WidgetSpan(
                                                                child: Icon(
                                                                  Icons.person,
                                                                  size: 13,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: (item.members[index]["kd1_member"] + item.members[index]["kd1_token"]).toString(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                            sb5,
                                            Text(
                                              tokenUsed ? item.members[index]["name"] : item.members[index]["id"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black, fontSize: Get.width * 0.25 * 0.12, height: 1),
                                            ),
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
