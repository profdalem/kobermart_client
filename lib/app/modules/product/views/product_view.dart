import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({Key? key}) : super(key: key);
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
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            sb15,
            Container(
              decoration: Shadow1(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Get.width,
                    width: Get.width,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://picsum.photos/200/300",
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kopi Sachet 3in1 Instant Coffee Mocca ",
                          style: TextStyle(fontSize: 20),
                        ),
                        sb10,
                        Text(
                          "Rp 10.000",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        sb10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Stok: 120"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Terjual: 50"),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          bg_anggota(),
                          bg_kd(kd: "1", nominal: 1),
                          bg_kd(kd: "2", nominal: 2),
                          bg_kd(kd: "3", nominal: 3),
                          bg_kd(kd: "4", nominal: 4),
                          bg_kd(kd: "5", nominal: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sb15,
            Container(
              decoration: Shadow1(),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Deskripsi"),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Gravida viverra tristique sapien massa eu nisl dis. Venenatis parturient malesuada volutpat massa ut vehicula pharetra velit. Lacus amet in tincidunt mattis facilisi diam.")
                  ],
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
}

class bg_anggota extends StatelessWidget {
  const bg_anggota({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade400)),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(children: [
          Text(
            "Anggota",
            style: TextStyle(fontSize: 12, color: Colors.orange.shade800),
          ),
          Text(
            "2%",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.orange.shade800),
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
  final int nominal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: Get.width * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey.shade400)),
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
                fontSize: 18,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShadowBottom(),
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          sb10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PanelTitle(title: "Jumlah"),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.orange.shade300,
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        alignment: Alignment.center,
                        width: Get.width * 0.2,
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 18),
                        )),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          sb15,
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
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber.shade700))),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.CART);
                    },
                    child: Text("+ Keranjang"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue))),
              ),
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
