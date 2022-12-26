import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/members_controller.dart';

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
          onRefresh: () => memberC.generateKd(),
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
                () => memberC.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : (memberC.authC.downlineList(memberC.keyword.value).isNotEmpty
                        ? PanelKedalaman(
                            memberC: memberC,
                          )
                        : Center(
                            child: Text("Kosong"),
                          )),
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
              borderRadius: BorderRadius.circular(10),
            )),
            elevation: MaterialStateProperty.all(1),
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
    return Obx(
      () => memberC.authC.loading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex, isExpanded) {
                memberC.kd[panelIndex].isExpanded.value = !isExpanded;
              },
              animationDuration: Duration(milliseconds: 500),
              children: memberC.kd.map<ExpansionPanel>(
                (DaftarKedalaman item) {
                  if (item.members.length == 0) {
                    return ExpansionPanel(
                        headerBuilder: (ctx, bool) {
                          return SizedBox();
                        },
                        body: SizedBox());
                  } else {
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: item.isExpanded.value,
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
                                width: Get.width*0.25,
                                child: Card(
                                    shadowColor: Colors.transparent,
                                    child: TextButton(
                                      onPressed: () {
                                        if (tokenUsed) {
                                          Get.toNamed(Routes.MEMBERPROFILE, arguments: {
                                            "id": item.members[index]["id"],
                                            "name": item.members[index]["name"],
                                          });
                                        } else {
                                          Get.toNamed(Routes.TOKENDETAIL, arguments: {"tokenCode": item.members[index]["id"]});
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
                                                backgroundImage: tokenUsed ? CachedNetworkImageProvider(PROFILE_IMG): null,
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
                                                boxShadow: [BoxShadow(blurRadius: 1, color: Colors.grey.shade500)]
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                                      children: [
                                                        WidgetSpan(
                                                          child: Icon(Icons.person, size: 13, color: Colors.white,),
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
                                            tokenUsed
                                                ? item.members[index]["name"]
                                                : item.members[index]["id"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.black, fontSize: Get.width*0.25*0.12, height: 1),
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
                    );
                  }
                },
              ).toList(),
            ),
    );
  }
}

class CariButton extends StatelessWidget {
  CariButton({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<MembersController>();

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
          controller.generateKd();
        },
      ),
    );
  }
}

void openProfile(String id) {
  Get.toNamed(Routes.MEMBERPROFILE);
}
