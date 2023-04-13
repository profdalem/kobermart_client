import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';
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
          onRefresh: () => memberC.updateDownlines(),
          child: ListView(
            children: [
              sb15,
              // Panel pencarian anggota
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     children: [
              //       CariButton(),
              //     ],
              //   ),
              // ),
              // sb15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Tindakan"),
              ),
              sb15,
              // Panel pilihan tindakan
              Container(
                height: Get.width * 0.25,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PanelTitle(
                      title: "Daftar Kedalaman",
                    ),
                    GestureDetector(
                      onTap: () {
                        print("cari anggota");
                        memberC.bottomSheetSearchMember(context, 0);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Text(
                              "Cari Anggota",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(
                              Icons.search_rounded,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => memberC.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : (memberC.authC
                          .downlineList(memberC.keyword.value, false)
                          .isNotEmpty
                      ? PanelAnggota()
                      : Center(child: Text("Kosong")))),

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

class PanelAnggota extends StatelessWidget {
  PanelAnggota({
    Key? key,
  }) : super(key: key);
  final authC = Get.find<AuthController>();
  final memberC = Get.find<MembersController>();

  @override
  Widget build(BuildContext context) {
    if (memberC.expandStatusList.isEmpty) {
      var status = <panelExpandStatus>[];
      for (var i = 0; i < authC.downlineList("", false).length; i++) {
        status.add(panelExpandStatus(i, i < 5 ? true : false));
      }
      memberC.expandStatusList.value = status;
    }

    return Obx(() => authC.downlines.isEmpty
        ? SizedBox()
        : Column(
            children: List.generate(
                authC.downlineList("", false).length,
                (index) => Container(
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.grey.shade100))),
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            memberC.expandStatusList[index].isExpand
                                ? memberC.expandStatusList[index].closePanel()
                                : memberC.expandStatusList[index].openPanel();
                            memberC.expandStatusList.refresh();
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    PanelTitle(title: "KD ${index + 1}"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: Colors.amber.shade700,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                          '${authC.downlineList("", false)[index].length} terisi',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    //   decoration: BoxDecoration(color: Colors.blue.shade500, borderRadius: BorderRadius.circular(15)),
                                    //   child: Text('${NumberFormat("#,##0", "id_ID").format(pow(10, index + 1) - authC.downlineList("", false)[index].length)} kosong',
                                    //       style: TextStyle(fontSize: 12, color: Colors.white)),
                                    // ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    memberC.expandStatusList[index].isExpand
                                        ? Icon(Icons.keyboard_arrow_up_outlined)
                                        : Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        if (memberC.expandStatusList[index].isExpand)
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            width: Get.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  children: List.generate(
                                      authC
                                                  .downlineList(
                                                      "", false)[index]
                                                  .length <=
                                              10
                                          ? authC
                                              .downlineList("", false)[index]
                                              .length
                                          : 10, (index2) {
                                    Widget item;
                                    var tokenUsed = false;
                                    if (authC.downlineList("", false)[index]
                                            [index2]["type"] ==
                                        "member") {
                                      tokenUsed = true;
                                    }

                                    item = Container(
                                      width: Get.width * 0.25,
                                      child: Card(
                                          shadowColor: Colors.transparent,
                                          child: TextButton(
                                            onPressed: () {
                                              if (tokenUsed) {
                                                Get.toNamed(
                                                    Routes.MEMBERPROFILE,
                                                    arguments: {
                                                      "id": authC.downlineList(
                                                              "", false)[index]
                                                          [index2]["id"],
                                                      "name":
                                                          authC.downlineList("",
                                                                  false)[index]
                                                              [index2]["name"],
                                                    });
                                              } else {
                                                Get.toNamed(Routes.TOKENDETAIL,
                                                    arguments: {
                                                      "tokenCode":
                                                          authC.downlineList("",
                                                                  false)[index]
                                                              [index2]["id"]
                                                    });
                                              }
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundColor:
                                                            tokenUsed
                                                                ? Colors
                                                                    .transparent
                                                                : Colors.grey
                                                                    .shade200,
                                                        backgroundImage: tokenUsed
                                                            ? CachedNetworkImageProvider(
                                                                authC.downlineList(
                                                                            "",
                                                                            false)[index]
                                                                        [index2]
                                                                    ["imgurl"])
                                                            : null,
                                                        child: tokenUsed
                                                            ? SizedBox()
                                                            : Text("token"),
                                                      ),
                                                    ),
                                                    if (tokenUsed)
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .amber
                                                                  .shade800,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(15)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    blurRadius:
                                                                        1,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500)
                                                              ]),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 2,
                                                                    horizontal:
                                                                        5),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                children: [
                                                                  WidgetSpan(
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 13,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: (authC.downlineList("", false)[index][index2]["kd1_member"] +
                                                                            authC.downlineList("",
                                                                                false)[index][index2]["kd1_token"])
                                                                        .toString(),
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
                                                      ? capitalizeIt(
                                                          authC.downlineList("",
                                                                  false)[index]
                                                              [index2]["name"])
                                                      : authC.downlineList(
                                                              "", false)[index]
                                                          [index2]["id"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: Get.width *
                                                          0.25 *
                                                          0.12,
                                                      height: 1),
                                                ),
                                              ],
                                            ),
                                          )),
                                    );

                                    return item;
                                  }),
                                ),
                                if (authC
                                        .downlineList("", false)[index]
                                        .length >=
                                    10)
                                  Container(
                                    width: Get.width * 0.25,
                                    child: Card(
                                        shadowColor: Colors.transparent,
                                        child: TextButton(
                                          onPressed: () {
                                            memberC.bottomSheetSearchMember(
                                                context, index + 1);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: null,
                                                  child: Icon(
                                                    Icons.more_horiz,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              sb5,
                                              Text(
                                                "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        Get.width * 0.25 * 0.12,
                                                    height: 1),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                              ],
                            ),
                          )
                      ]),
                    )),
          ));
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
  }) : super(key: key);

  final memberC = Get.find<MembersController>();

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
                // memberC.kd[panelIndex].isExpanded.value = !isExpanded;
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
                              var tokenUsed = false;
                              if (item.members[index]["type"] == "member") {
                                tokenUsed = true;
                              }
                              return Container(
                                width: Get.width * 0.25,
                                child: Card(
                                    shadowColor: Colors.transparent,
                                    child: TextButton(
                                      onPressed: () {
                                        if (tokenUsed) {
                                          Get.toNamed(Routes.MEMBERPROFILE,
                                              arguments: {
                                                "id": item.members[index]["id"],
                                                "name": item.members[index]
                                                    ["name"],
                                              });
                                        } else {
                                          Get.toNamed(Routes.TOKENDETAIL,
                                              arguments: {
                                                "tokenCode": item.members[index]
                                                    ["id"]
                                              });
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundColor: tokenUsed
                                                      ? Colors.transparent
                                                      : Colors.grey.shade200,
                                                  backgroundImage: tokenUsed
                                                      ? CachedNetworkImageProvider(
                                                          PROFILE_IMG)
                                                      : null,
                                                  child: tokenUsed
                                                      ? SizedBox()
                                                      : Text("token"),
                                                ),
                                              ),
                                              if (tokenUsed)
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .amber.shade800,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 1,
                                                              color: Colors.grey
                                                                  .shade500)
                                                        ]),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 5),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 13,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: (item.members[
                                                                              index]
                                                                          [
                                                                          "kd1_member"] +
                                                                      item.members[
                                                                              index]
                                                                          [
                                                                          "kd1_token"])
                                                                  .toString(),
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
                                                ? capitalizeIt(
                                                    item.members[index]["name"])
                                                : item.members[index]["id"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    Get.width * 0.25 * 0.12,
                                                height: 1),
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

void openProfile(String id) {
  Get.toNamed(Routes.MEMBERPROFILE);
}
