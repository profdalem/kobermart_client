import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/product_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  ProductView({Key? key}) : super(key: key);
  final productC = Get.find<MainProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Produk',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: Shadow1(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    height: Get.width,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [ListView.separated(
                          controller: controller.slide,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                                height: Get.width,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          productData()["imgurl"].toString(),
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                          separatorBuilder: (context, index) => SizedBox(),
                          itemCount: 5),
                          Obx(()=> Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
                            child: Text("${controller.page.value}/${5.toString()}", style: TextStyle(fontSize: 12),))),],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          productData()["name"].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        sb10,
                        Text(
                          NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 0).format(productData()["sell_price"]),
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        sb10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Stok: ${productData()["stockQty"].toString()}"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Terjual: n/a"),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                print("barcode");
                                // await controller.slide.animateTo(360 * 2, duration: Duration(seconds: 1), curve: Curves.elasticInOut).then((value) => print("done")).catchError((err)=>print(err));
                              },
                              child: Text(
                                "Lihat Barcode",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            sb15,
            Container(
              width: Get.width,
              decoration: Shadow1(),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Bagian"),
                    sb10,
                    Row(
                      children: [
                        Expanded(child: bg_anggota(number: double.parse(productData()["bagian"][0].toString()),),),
                        Expanded(child: bg_kd(kd: "1", nominal: double.parse(productData()["bagian"][1].toString())),),
                        Expanded(child: bg_kd(kd: "2", nominal: double.parse(productData()["bagian"][2].toString())),),
                        Expanded(child: bg_kd(kd: "3", nominal: double.parse(productData()["bagian"][3].toString())),),
                        Expanded(child: bg_kd(kd: "4", nominal: double.parse(productData()["bagian"][4].toString())),),
                        Expanded(child: bg_kd(kd: "5", nominal: double.parse(productData()["bagian"][5].toString())),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            sb15,
            Container(
              decoration: Shadow1(),
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [PanelTitle(title: "Deskripsi"), Text(productData()["desc"].toString())],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ]),
        ),
        bottomNavigationBar: ProductBottomBar(),
      ),
    );
  }

  productData() {
    return productC.products.where((p0) => p0["id"] == Get.arguments["id"]).toList()[0];
  }
}

class bg_anggota extends StatelessWidget {
  const bg_anggota({
    Key? key,
    required this.number,
  }) : super(key: key);

  final double number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.grey.shade200, border: Border.all(color: Colors.grey.shade400)),
      child: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Column(children: [
          Text(
            "Saya",
            style: TextStyle(fontSize: 12, color: Colors.orange.shade800),
          ),
          Text(
            "2%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange.shade800),
          ),
        ]),
      ),
    );
  }
}

class bg_kd extends StatelessWidget {
  const bg_kd({
    Key? key,
    required this.kd,
    required this.nominal,
  }) : super(key: key);

  final String kd;
  final double nominal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        // width: Get.width * 0.12,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.grey.shade200, border: Border.all(color: Colors.grey.shade400)),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(children: [
            Text(
              "KD${kd}",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              "${nominal.toString()}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ProductBottomBar extends StatelessWidget {
  ProductBottomBar({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShadowBottom(),
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sb10,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       PanelTitle(title: "Jumlah"),
          //       Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               controller.decrement();
          //             },
          //             onLongPress: () {
          //               controller.tenDecrement();
          //             },
          //             child: Icon(
          //               Icons.remove_circle,
          //               color: Colors.orange.shade300,
          //             ),
          //           ),
          //           Container(
          //               decoration: BoxDecoration(
          //                   border:
          //                       Border(bottom: BorderSide(color: Colors.grey))),
          //               alignment: Alignment.center,
          //               width: Get.width * 0.2,
          //               child: Obx(() => Text(
          //                     controller.count.value.toString(),
          //                     style: TextStyle(fontSize: 18),
          //                   ))),
          //           GestureDetector(
          //             onTap: () {
          //               controller.increment();
          //             },
          //             onLongPress: () {
          //               controller.tenIncrement();
          //             },
          //             child: Icon(
          //               Icons.add_circle,
          //               color: Colors.green.shade700,
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          // sb15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.BUYNOW);
                    },
                    child: Text("Langsung Beli"),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber.shade700))),
              ),
              // SizedBox(
              //   width: 30,
              // ),
              // Expanded(
              //   flex: 5,
              //   child: ElevatedButton(
              //       onPressed: () {
              //         Get.offAndToNamed(Routes.CART);
              //       },
              //       child: Text("+ Keranjang"),
              //       style: ButtonStyle(
              //           backgroundColor:
              //               MaterialStateProperty.all(Colors.blue))),
              // ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          sb15
        ],
      ),
    );
  }
}
