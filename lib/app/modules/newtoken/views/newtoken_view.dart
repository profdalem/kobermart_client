// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/modules/widgets/success_token.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/newtoken_controller.dart';

class NewtokenView extends GetView {
  NewtokenView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();
  final authC = Get.find<AuthController>();
  final newTokenC = Get.put(NewtokenController());

  @override
  Widget build(BuildContext context) {
    print(homeC.kd1count.value);
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
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PanelTitle(title: "Pilih upline token")]),
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
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: PanelTitle(title: "Saya"),
                    ),
                  ),
                  sb10,
                  Container(
                    decoration: Shadow1(),
                    child: ListTile(
                      onTap: () {
                        // pastikan slot kd1 tidak penuh
                        if (homeC.kd1count.value == authC.kd1limit.value) {
                          Get.defaultDialog(
                            title: "Slot Penuh",
                            content:
                                Text("Slot di KD1 anda telah terisi semua"),
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
                                  onPressed: () async {
                                    newTokenC.isLoading.value = true;
                                    await newTokenC
                                        .newToken(
                                            homeC.id.value, homeC.id.value)
                                        .then((value) async {
                                      if (value["success"]) {
                                        await homeC.getInitialData();
                                        Get.back();
                                        newTokenC.isLoading.value = false;
                                        Get.to(() => SuccessTokenPage(),
                                            arguments: {
                                              "token": value["token"]
                                            });
                                      } else {
                                        Get.back();
                                        newTokenC.isLoading.value = false;
                                        Get.defaultDialog(
                                            title: "Gagal",
                                            content: Text(value["message"]));
                                      }
                                    });
                                  },
                                  child: Text("Yakin")));
                        }
                      },
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                        // backgroundImage: CachedNetworkImageProvider(
                        //     "https://i.pravatar.cc/150?img=1"),
                      ),
                      title: PanelTitle(title: homeC.name.value),
                      subtitle: Text(homeC.upline["name"]),
                      trailing: Chip(
                        label: Text((int.parse(homeC.settings["kd1limit"]) -
                                homeC.kd1count.value)
                            .toString()),
                        backgroundColor: Colors.orange.shade200,
                      ),
                    ),
                  ),
                  sb15,
                  homeC.downlines.isEmpty
                      ? Center(child: Text("Anggota tidak ditemukan"))
                      : Column(
                          children: List.generate(homeC.downlines.value.length,
                              (index) {
                            var showTitle = false;
                            for (var i = 0;
                                i < homeC.downlines[index].length;
                                i++) {
                              if (homeC.downlines[index][i]['memberData']
                                  ['tokenUsed']) {
                                showTitle = true;
                              }
                            }
                            return Column(
                              children: [
                                if (showTitle)
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child:
                                          PanelTitle(title: "KD ${index + 1}"),
                                    ),
                                  ),
                                sb10,
                                Column(
                                  children: List.generate(
                                      homeC.downlines.value[index].length,
                                      (kdindex) => homeC.downlines[index]
                                                  [kdindex]['memberData']
                                              ['tokenUsed']
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12),
                                              child: Container(
                                                decoration: Shadow1(),
                                                child: ListTile(
                                                  onTap: () {
                                                    // pastikan slot kd1 tidak penuh
                                                    if (int.parse(
                                                            homeC.settings[
                                                                "kd1limit"]) ==
                                                        homeC.downlines[index]
                                                                [kdindex]
                                                            ['kd1count']) {
                                                      Get.defaultDialog(
                                                        title: "Slot Penuh",
                                                        content: Text(
                                                            "Slot di KD1 anda telah terisi semua"),
                                                      );
                                                    } else {
                                                      Get.defaultDialog(
                                                          barrierDismissible:
                                                              true,
                                                          title: "Konfirmasi",
                                                          content: Center(
                                                              child: Obx(
                                                            () => newTokenC
                                                                    .isLoading
                                                                    .value
                                                                ? Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  )
                                                                : Text(
                                                                    "Jadikan ${homeC.downlines[index][kdindex]['memberData']['name']} sebagai upline token?"),
                                                          )),
                                                          cancel: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: Text(
                                                                    "Batal")),
                                                          ),
                                                          confirm:
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    newTokenC
                                                                        .isLoading
                                                                        .value = true;
                                                                    await newTokenC
                                                                        .newToken(
                                                                            homeC.downlines[index][kdindex][
                                                                                'id'],
                                                                            homeC
                                                                                .id.value)
                                                                        .then(
                                                                            (value) async {
                                                                      print(value[
                                                                          "success"]);
                                                                      if (value[
                                                                          "success"]) {
                                                                        await homeC
                                                                            .getInitialData();
                                                                        Get.back();
                                                                        newTokenC
                                                                            .isLoading
                                                                            .value = false;
                                                                        Get.to(
                                                                            () =>
                                                                                SuccessTokenPage(),
                                                                            arguments: {
                                                                              "token": value["token"]
                                                                            });
                                                                      } else {
                                                                        Get.back();
                                                                        newTokenC
                                                                            .isLoading
                                                                            .value = false;
                                                                        Get.defaultDialog(
                                                                            title:
                                                                                "Gagal",
                                                                            content:
                                                                                Text(value["message"]));
                                                                        newTokenC
                                                                            .isLoading
                                                                            .value = false;
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                      "Yakin")));
                                                    }
                                                  },
                                                  leading: CircleAvatar(
                                                    child: Icon(Icons.person),
                                                    // backgroundImage:
                                                    //     CachedNetworkImageProvider(
                                                    //         "https://i.pravatar.cc/150?img=${index + 5}"),
                                                  ),
                                                  title: PanelTitle(
                                                      title: homeC.downlines[index]
                                                                          [kdindex]
                                                                      ['memberData']
                                                                  ['name'] !=
                                                              null
                                                          ? homeC.downlines[index]
                                                                      [kdindex]
                                                                  ['memberData']
                                                              ['name']
                                                          : homeC.downlines[index]
                                                                      [kdindex]
                                                                  ['memberData']
                                                              ['tokenCode']),
                                                  subtitle: Text(
                                                      "Upline: ${homeC.downlines[index][kdindex]['uplineData']['name']}"),
                                                  trailing: Chip(
                                                    label: Text((int.parse(homeC
                                                                    .settings[
                                                                "kd1limit"]) -
                                                            homeC.downlines[
                                                                        index]
                                                                    [kdindex]
                                                                ['kd1count'])
                                                        .toString()),
                                                    backgroundColor:
                                                        Colors.orange.shade200,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox()),
                                )
                              ],
                            );
                          }, growable: false),
                        ),
                  sb15,
                ],
              ),
            ),
          ],
        ),
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
