import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';
import '../controllers/balancetransfer_controller.dart';

class BalancetransferView extends GetView<BalancetransferController> {
  BalancetransferView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
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
                    Obx(()=> Column(
                      children: List.generate(authC.downlineList(controller.keyword.value).length, (index) {
                        var showtitle = false;
                        authC.downlineList(controller.keyword.value)[index].forEach((el) {
                          if (el["type"] == "member") {
                            showtitle = true;
                          }
                        });
                        return Column(
                          children: [
                            if(showtitle) Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: PanelTitle(title: "KD ${index + 1}"),
                              ),
                            ),
                            if(showtitle) sb5,
                            Column(
                              children: List.generate(
                                  authC.downlineList(controller.keyword.value)[index].length,
                                  (kdindex) => authC.downlineList(controller.keyword.value)[index][kdindex]["type"] == "member"
                                      ? Padding(
                                          padding: const EdgeInsets.only(bottom: 0),
                                          child: Card(
                                            elevation: 1,
                                            child: ListTile(
                                              onTap: () {
                                                
                                                    Get.toNamed(Routes.INPUTNUMBER, arguments: {"title": TRANSFER, "recipient": {
                                                      "name": authC.downlineList(controller.keyword.value)[index][kdindex]['name'],
                                                      "id": authC.downlineList(controller.keyword.value)[index][kdindex]['id'],
                                                    }});
                                                  
                                              },
                                              leading: CircleAvatar(
                                                backgroundImage:CachedNetworkImageProvider(PROFILE_IMG),
                                              ),
                                              title: PanelTitle(
                                                  title: authC.downlineList(controller.keyword.value)[index][kdindex]['name'] != null
                                                      ? authC.downlineList(controller.keyword.value)[index][kdindex]['name']
                                                      : authC.downlineList(controller.keyword.value)[index][kdindex]['id']),
                                              subtitle: Text("Upline: ${authC.downlineList(controller.keyword.value)[index][kdindex]['uplineName']}"),
                                              trailing: Chip(
                                                label: Text((authC.settings["kd1limit"] -
                                                        (authC.downlineList(controller.keyword.value)[index][kdindex]['kd1_token'] +
                                                            authC.downlineList(controller.keyword.value)[index][kdindex]['kd1_member']))
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
                    ),)
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
  CariButton({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<BalancetransferController>();
  

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
        },
      ),
    );
  }
}
