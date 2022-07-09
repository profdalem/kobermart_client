import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import 'package:username_gen/username_gen.dart';

import '../controllers/balancetransfer_controller.dart';

class BalancetransferView extends GetView<BalancetransferController> {
  const BalancetransferView({Key? key}) : super(key: key);
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
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PanelTitle(title: "Pilih anggota")]),
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
                      child: PanelTitle(title: "KD 1"),
                    ),
                  ),
                  sb10,
                  Column(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: Shadow1(),
                          child: ListTile(
                            onTap: todo,
                            leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/150?img=${index + 5}")),
                            title:
                                PanelTitle(title: UsernameGen.generateWith()),
                            subtitle: Text("Upline: Margor Robbie"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sb15,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: PanelTitle(title: "KD 2"),
                    ),
                  ),
                  sb10,
                  Column(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: Shadow1(),
                          child: ListTile(
                            onTap: () {
                              print("klik");
                            },
                            leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    "https://i.pravatar.cc/150?img=${index + 10}")),
                            title:
                                PanelTitle(title: UsernameGen.generateWith()),
                            subtitle: Text("Upline: Margor Robbie"),
                          ),
                        ),
                      ),
                    ),
                  )
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
