import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifikasi'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Hari ini"),
              ),
              sb10,
              Column(
                children: List.generate(2, (index) {
                  return Column(
                    children: [
                      NotificationItem(),
                      sb10,
                    ],
                  );
                }),
              ),
              sb15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Kemarin"),
              ),
              sb10,
              Column(
                children: List.generate(2, (index) {
                  return Column(
                    children: [
                      NotificationItem(),
                      sb10,
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Shadow1(),
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width: Get.width * 0.06,
                    height: Get.width * 0.06,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Expanded(flex: 12, child: Text("Belanja")),
              Expanded(
                  flex: 4,
                  child: Text(
                    "12.21",
                    textAlign: TextAlign.end,
                  )),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                  flex: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PanelTitle(
                        title: "Barang sudah diantarkan",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Produk yang anda pesan berupa Energen Sachet 50 gram telah diantarkan.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
