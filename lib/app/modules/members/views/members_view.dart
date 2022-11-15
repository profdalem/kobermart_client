import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/tokendetail/views/tokendetail_view.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/members_controller.dart';
import 'package:username_gen/username_gen.dart';

class MembersView extends StatelessWidget {
  final memberC = Get.put(MembersController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: DefaultAppBar(
            pageTitle: "Anggota",
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(Duration(seconds: 1)),
          child: ListView(
            children: [
              sb15,
              // Panel pencarian anggota
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    CariButton(),
                  ],
                ),
              ),
              sb15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Tindakan"),
              ),
              sb15,
              // Panel pilihan tindakan
              Container(
                height: MediaQuery.of(context).size.width * 0.25,
                child: ListView(
                  padding: EdgeInsets.only(left: 15, top: 3, bottom: 3),
                  scrollDirection: Axis.horizontal,
                  children: [
                    TindakanMember(
                        img: "tokenbaru",
                        title: "Token Baru",
                        todo: () {
                          Get.toNamed(Routes.NEWTOKEN);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    TindakanMember(
                        img: "daftartoken",
                        title: "Daftar Token",
                        todo: () {
                          Get.toNamed(Routes.TOKENLIST);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    TindakanMember(
                        img: "riwayatgabung",
                        title: "Riwayat Gabung",
                        todo: () {
                          Get.toNamed(Routes.MEMBERHISTORY);
                        }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Container(
                    child: PanelTitle(
                  title: "Daftar Kedalaman",
                )),
              ),
              Obx(
                () => memberC.homeC.downlines.isNotEmpty
                    ? PanelKedalaman(
                        memberC: memberC,
                      )
                    : Center(
                        child: Text("Kosong"),
                      ),
              ),

              sb15
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(
          context: context,
          menu1: false,
          menu2: false,
          menu3: true,
          menu4: false,
        ),
      ),
    );
  }

  List<dynamic> getFilteredDownlines(List downlines) {
    List result = downlines;

    return result;
  }
}

class TindakanMember extends StatelessWidget {
  const TindakanMember({
    Key? key,
    required this.img,
    required this.title,
    required this.todo,
  }) : super(key: key);

  final String img;
  final String title;
  final todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
            elevation: MaterialStateProperty.all(3),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: todo,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/logo/${img}.svg",
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
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

  final MembersController memberC;

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
                          label: Text('${item.members.length} terisi',
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
                          label: Text(
                              '${slotSize - item.members.length} kosong',
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
                          var tokenUsed = item.members[index]["tokenUsed"];
                          return Container(
                            width: 100,
                            child: Card(
                                shadowColor: Colors.transparent,
                                child: TextButton(
                                  onPressed: () {
                                    if (tokenUsed) {
                                      Get.toNamed(Routes.MEMBERPROFILE,
                                          arguments: {
                                            "data": item.members[index]
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
                                            ? item.members[index]["memberData"]
                                                ["name"]
                                            : (FirebaseAuth.instance
                                                        .currentUser!.uid ==
                                                    item.members[index]
                                                            ["memberData"]
                                                        ["tokenCreator"]
                                                ? item.members[index]
                                                    ["memberData"]["tokenCode"]
                                                : "?"),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
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

void openProfile(String id) {
  Get.toNamed(Routes.MEMBERPROFILE);
}
