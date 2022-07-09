import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/widgets/success_token.dart';
import 'package:kobermart_client/style.dart';
import 'package:username_gen/username_gen.dart';

import '../controllers/newtoken_controller.dart';

class NewtokenView extends GetView<NewtokenController> {
  const NewtokenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var todo = () {
      Get.defaultDialog(
          barrierDismissible: true,
          title: "Konfirmasi",
          content: Text("Apakah anda yakin?"),
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
                Get.offAll(() => SuccessTokenPage());
              },
              child: Text("Yakin")));
    };
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
                      onTap: todo,
                      leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage("https://i.pravatar.cc/150?img=1")),
                      title: PanelTitle(title: "Username 1"),
                      subtitle: Text("Upline: Margor Robbie"),
                      trailing: Chip(
                        label: Text("Sisa 10"),
                        backgroundColor: Colors.orange.shade200,
                      ),
                    ),
                  ),
                  sb15,
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
                                backgroundImage: NetworkImage(
                                    "https://i.pravatar.cc/150?img=${index + 5}")),
                            title:
                                PanelTitle(title: UsernameGen.generateWith()),
                            subtitle: Text("Upline: Margor Robbie"),
                            trailing: Chip(
                              label: Text("Sisa 10"),
                              backgroundColor: Colors.orange.shade200,
                            ),
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
                                backgroundImage: NetworkImage(
                                    "https://i.pravatar.cc/150?img=${index + 10}")),
                            title:
                                PanelTitle(title: UsernameGen.generateWith()),
                            subtitle: Text("Upline: Margor Robbie"),
                            trailing: Chip(
                              label: Text("Sisa 10"),
                              backgroundColor: Colors.orange.shade200,
                            ),
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
