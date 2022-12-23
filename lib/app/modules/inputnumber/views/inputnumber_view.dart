import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/inputnumber_controller.dart';

class InputnumberView extends GetView<InputnumberController> {
  InputnumberView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments["title"];
    var icon = "";
    switch (title) {
      case TOPUP:
        icon = "assets/icons/icon-topup.svg";
        break;
      case WITHDRAWAL:
        icon = "assets/icons/icon-withdrawal.svg";
        break;
      case TRANSFER:
        icon = "assets/icons/icon-transfer.svg";
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: SvgPicture.asset(
                      icon,
                    ),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  title: Text(
                    controller.title == TRANSFER ? controller.recipient["name"] : controller.method.toString().capitalizeFirst!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(controller.title == TRANSFER ? "Tujuan Transfer" : "Metode ${title}", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: Container(
                      child: Row(
                    children: [
                      Text("Saldo anda: "),
                      Text(
                        "Rp${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      sb10,
                      Text(
                        "Nominal",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      sb10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Obx(() => Text(
                                      NumberFormat("#,##0", "id_ID").format(int.parse(controller.nominal.value)),
                                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                                onPressed: () {
                                  controller.nominal.value = "0";
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.grey.shade700,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        sb15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            KeyPad(number: "1"),
                            KeyPad(number: "2"),
                            KeyPad(number: "3"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            KeyPad(number: "4"),
                            KeyPad(number: "5"),
                            KeyPad(number: "6"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            KeyPad(number: "7"),
                            KeyPad(number: "8"),
                            KeyPad(number: "9"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            KeyPad(number: "0"),
                            KeyPad(number: "000"),
                            KeyPad(number: "<-"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
                      child: Obx(
                        () => controller.isLoading.value
                            ? LayoutBuilder(builder: (ctx, constraint) {
                                return Container(width: constraint.maxHeight, child: CircularProgressIndicator());
                              })
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // controller.setNewTopUp();
                                    if (int.parse(controller.nominal.value) > 0) {
                                      controller.openBottomSheetModal(context);
                                    }
                                  },
                                  child: Text("Lanjut"),
                                  style: int.parse(controller.nominal.value) > 0? ButtonStyle(elevation: MaterialStatePropertyAll(1)) : ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade300), elevation: MaterialStatePropertyAll(1)),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  final String number;
  KeyPad({Key? key, required this.number}) : super(key: key);

  final c = Get.find<InputnumberController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.30,
      height: Get.width * 0.18,
      child: ElevatedButton(
        onPressed: () {
          if (number == "<-") {
            c.delNumber();
          } else {
            c.addNumber(number);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          elevation: MaterialStatePropertyAll(0),
        ),
        child: number == "<-"
            ? Icon(
                Icons.backspace_rounded,
                color: Colors.grey.shade900,
              )
            : Text(
                number,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.grey.shade900),
              ),
      ),
    );
  }
}
