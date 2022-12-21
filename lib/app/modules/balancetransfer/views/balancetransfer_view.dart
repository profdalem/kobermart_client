import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';
import 'package:username_gen/username_gen.dart';
import '../controllers/balancetransfer_controller.dart';

class BalancetransferView extends GetView<BalancetransferController> {
  BalancetransferView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var todo = () {
      Get.toNamed(Routes.TRANSFERNOMINAL);
    };

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transfer Dana'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [PanelTitle(title: "Pilih tujuan")]),
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
                  homeC.downlines.isEmpty
                      ? Center(child: Text("Anggota tidak ditemukan"))
                      : Column(
                          children: List.generate(homeC.downlines.value.length, (index) {
                            var showTitle = false;
                            for (var i = 0; i < homeC.downlines[index].length; i++) {
                              if (homeC.downlines[index][i]['memberData']['tokenUsed']) {
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
                                      child: PanelTitle(title: "KD ${index + 1}"),
                                    ),
                                  ),
                                sb10,
                                Column(
                                  children: List.generate(
                                      homeC.downlines[index].length,
                                      (kdindex) => homeC.downlines[index][kdindex]['memberData']['tokenUsed']
                                          ? Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: Card(
                                                elevation: 1,
                                                child: ListTile(
                                                  onTap: () {
                                                    Get.toNamed(Routes.INPUTNUMBER, arguments: {"title": TRANSFER, "recipient": {
                                                      "name": homeC.downlines[index][kdindex]['memberData']['name'],
                                                      "id": homeC.downlines[index][kdindex]['memberData']['tokenCode'],
                                                    }});
                                                  },
                                                  leading: CircleAvatar(
                                                    child: Icon(Icons.person),
                                                    // backgroundImage:
                                                    //     CachedNetworkImageProvider(
                                                    //         "https://i.pravatar.cc/150?img=${index + 5}"),
                                                  ),
                                                  title: PanelTitle(
                                                      title: homeC.downlines[index][kdindex]['memberData']['name'] != null
                                                          ? homeC.downlines[index][kdindex]['memberData']['name']
                                                          : homeC.downlines[index][kdindex]['memberData']['tokenCode']),
                                                  subtitle: Text("Upline: ${homeC.downlines[index][kdindex]['uplineData']['name']}"),
                                                ),
                                              ),
                                            )
                                          : SizedBox()),
                                )
                              ],
                            );
                          }, growable: false),
                        ),
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
