// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:kobermart_client/style.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../routes/app_pages.dart';

class MembersController extends GetxController {
  var authC = Get.find<AuthController>();

  var isLoading = false.obs;
  var keyword = "".obs;
  var expandStatusList = <panelExpandStatus>[].obs;
  late TextEditingController searchC;

  List<DaftarKedalaman> kd = <DaftarKedalaman>[].obs;
  @override
  Future<void> onInit() async {
    searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    initMember();
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  Future<void> initMember() async {
    isLoading.value = true;
    generateKd();
    isLoading.value = false;
  }

  Future<void> updateDownlines() async {
    authC.downlines.value = await getUpdatedDownlines(Auth.currentUser!.uid);
  }

  Future<void> generateKd() async {
    devLog("generate kd start");
    isLoading.value = true;
    if (authC.downlines.isEmpty) {
      try {
        kd = await generateItems(authC.downlineList(keyword.value, false).length, authC.downlineList(keyword.value, false)).obs;
      } on FirebaseException catch (e) {
        print(e.message);
      }
    } else {
      kd = await generateItems(authC.downlineList(keyword.value, false).length, authC.downlineList(keyword.value, false)).obs;
    }
    isLoading.value = false;
  }

  List<DaftarKedalaman> generateItems(int numberOfItems, List downlines) {
    return List.generate(numberOfItems, (int index) {
      return DaftarKedalaman(header: "Kedalaman ${index}", isExpanded: true.obs, members: downlines[index]);
    });
  }

  void bottomSheetSearchMember(BuildContext context, int kd) {
    if (FocusManager.instance.primaryFocus!.hasFocus) FocusManager.instance.primaryFocus?.unfocus();
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      duration: Duration(milliseconds: 300),
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
          height: Get.height * 0.9,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 25,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
              ),
              sb15,
              CariButton(),
              sb15,
              Obx(() => Expanded(
                  child: getSearchResult(keyword.value, kd).length == 0
                      ? Center(
                          child: Text("Kosong"),
                        )
                      : GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          children: List.generate(
                              getSearchResult(keyword.value, kd).length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MEMBERPROFILE, arguments: {
                                        "id": getSearchResult(keyword.value, kd)[index]["id"],
                                        "name": getSearchResult(keyword.value, kd)[index]["name"],
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      color: Colors.grey.shade100,
                                      width: double.infinity,
                                      // alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          sb5,
                                          CircleAvatar(
                                            backgroundImage: CachedNetworkImageProvider(getSearchResult(keyword.value, kd)[index]["imgurl"]),
                                          ),
                                          sb5,
                                          Text(
                                            getSearchResult(keyword.value, kd)[index]["name"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12, height: 1.2),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ))),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))),
                  child: Text("Tutup"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DaftarKedalaman {
  DaftarKedalaman({
    required this.header,
    required this.isExpanded,
    required this.members,
  });

  String header;
  RxBool isExpanded;
  List<dynamic> members;
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
        autofocus: true,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFE4E4E4),
            hintText: "Cari anggota",
            hintStyle: TextStyle(
              color: Colors.grey,
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
          controller.keyword.value = value;
        },
      ),
    );
  }
}

class panelExpandStatus {
  int kd;
  bool isExpand;
  panelExpandStatus(this.kd, this.isExpand);

  void closePanel() {
    isExpand = false;
  }

  void openPanel() {
    isExpand = true;
  }
}
