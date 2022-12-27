// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/modules/widgets/success_token.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:kobermart_client/style.dart';
import '../../../../constants.dart';
import '../controllers/newtoken_controller.dart';

class NewtokenView extends GetView {
  NewtokenView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();
  final authC = Get.find<AuthController>();
  final newTokenC = Get.put(NewtokenController());

  @override
  Widget build(BuildContext context) {
    String name = "";
    String id = "";
    if (Auth.currentUser != null) {
      name = Auth.currentUser!.displayName!;
      id = Auth.currentUser!.uid;
    }
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: AppBar(
          title: const Text('Token Baru'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [PanelTitle(title: "Pilih upline")]),
            sb20,
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
              child: Obx(
                () => ListView(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: PanelTitle(title: "Saya"),
                      ),
                    ),
                    sb10,
                    Card(
                      elevation: 1,
                      child: ListTile(
                        onTap: () {
                          // pastikan slot kd1 tidak penuh
                          if (authC.kd1_member.value + authC.kd1_token.value == authC.settings["kd1limit"]) {
                            Get.defaultDialog(
                              title: "Slot Penuh",
                              content: Text("Slot di KD1 anda telah terisi semua"),
                            );
                          } else {
                            Get.defaultDialog(
                                barrierDismissible: true,
                                title: "Konfirmasi",
                                content: Obx(() => newTokenC.isLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text("Buat token dibawah anda?")),
                                cancel: Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Batal")),
                                ),
                                confirm: ElevatedButton(
                                    onPressed: () {
                                      // Generate Token dibawah Saya
                                      newTokenC.isLoading.value = true;
                                      newTokenC.newToken(id, id).then((value) {
                                        print(value);
                                        if (value["success"]) {
                                          Get.back();
                                          Get.to(() => SuccessTokenPage(), arguments: {"token": value["token"]});
                                        } else {
                                          Get.back();
                                          Get.defaultDialog(title: "Gagal", content: Text(value["message"]));
                                        }
                                        newTokenC.isLoading.value = false;
                                      }).catchError((error) {
                                        print(error);
                                        newTokenC.isLoading.value = false;
                                      });
                                    },
                                    child: Text("Yakin")));
                          }
                        },
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(PROFILE_IMG),
                        ),
                        title: PanelTitle(title: name),
                        subtitle: Text(authC.uplineName.value),
                        trailing: Obx(() => Chip(
                              label: Text((authC.settings["kd1limit"] - (authC.kd1_member.value + authC.kd1_token.value)).toString()),
                              backgroundColor: Colors.orange.shade200,
                            )),
                      ),
                    ),
                    sb15,
                    Column(
                      children: List.generate(authC.downlineList(newTokenC.keyword.value).length, (index) {
                        var showtitle = false;
                        authC.downlineList(newTokenC.keyword.value)[index].forEach((el) {
                          if (el["type"] == "member") {
                            showtitle = true;
                          }
                        });
                        return Column(
                          children: [
                            if (showtitle)
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: PanelTitle(title: "KD ${index + 1}"),
                                ),
                              ),
                            if (showtitle) sb5,
                            Column(
                              children: List.generate(
                                  authC.downlineList(newTokenC.keyword.value)[index].length,
                                  (kdindex) => authC.downlineList(newTokenC.keyword.value)[index][kdindex]["type"] == "member"
                                      ? Padding(
                                          padding: const EdgeInsets.only(bottom: 0),
                                          child: Card(
                                            elevation: 1,
                                            child: ListTile(
                                              onTap: () {
                                                // pastikan slot kd1 tidak penuh
                                                if (authC.settings["kd1limit"] == authC.downlineList(newTokenC.keyword.value)[index][kdindex]['kd1count']) {
                                                  Get.defaultDialog(
                                                    title: "Slot Penuh",
                                                    content: Text("Slot di KD1 anda telah terisi semua"),
                                                  );
                                                } else {
                                                  Get.defaultDialog(
                                                      barrierDismissible: true,
                                                      title: "Konfirmasi",
                                                      content: Center(
                                                          child: Obx(
                                                        () => newTokenC.isLoading.value
                                                            ? Center(
                                                                child: CircularProgressIndicator(),
                                                              )
                                                            : Text(
                                                                "Jadikan ${authC.downlineList(newTokenC.keyword.value)[index][kdindex]['name']} sebagai upline token?"),
                                                      )),
                                                      cancel: Padding(
                                                        padding: const EdgeInsets.only(right: 50),
                                                        child: TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text("Batal")),
                                                      ),
                                                      confirm: ElevatedButton(
                                                          onPressed: () async {
                                                            newTokenC.isLoading.value = true;
                                                            await newTokenC
                                                                .newToken(authC.downlineList(newTokenC.keyword.value)[index][kdindex]['id'],
                                                                    authC.userCredential.value!.uid)
                                                                .then((value) async {
                                                              if (value["success"]) {
                                                                Get.back();
                                                                Get.to(() => SuccessTokenPage(), arguments: {"token": value["token"]});
                                                              } else {
                                                                Get.back();
                                                                newTokenC.isLoading.value = false;
                                                                Get.defaultDialog(title: "Gagal", content: Text(value["message"]));
                                                              }
                                                              newTokenC.isLoading.value = false;
                                                            });
                                                          },
                                                          child: Text("Yakin")));
                                                }
                                              },
                                              leading: CircleAvatar(
                                                backgroundImage: CachedNetworkImageProvider(PROFILE_IMG),
                                              ),
                                              title: PanelTitle(
                                                  title: authC.downlineList(newTokenC.keyword.value)[index][kdindex]['name'] != null
                                                      ? authC.downlineList(newTokenC.keyword.value)[index][kdindex]['name']
                                                      : authC.downlineList(newTokenC.keyword.value)[index][kdindex]['id']),
                                              subtitle: Text("Upline: ${authC.downlineList(newTokenC.keyword.value)[index][kdindex]['uplineName']}"),
                                              trailing: Chip(
                                                label: Text((authC.settings["kd1limit"] -
                                                        (authC.downlineList(newTokenC.keyword.value)[index][kdindex]['kd1_token'] +
                                                            authC.downlineList(newTokenC.keyword.value)[index][kdindex]['kd1_member']))
                                                    .toString()),
                                                backgroundColor: Colors.orange.shade200,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox()),
                            ),
                            sb15,
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CariButton extends StatelessWidget {
  CariButton({
    Key? key,
  }) : super(key: key);

  final newTokenC = Get.find<NewtokenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 30,
      child: TextField(
        controller: newTokenC.searchC,
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
          newTokenC.keyword.value = value.toString();
        },
      ),
    );
  }
}
