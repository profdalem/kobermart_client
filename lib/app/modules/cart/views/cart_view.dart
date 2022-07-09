import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/cart/controllers/item_controller.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keranjang Belanja'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            sb15,
            CartItem(),
            sb15,
            CartItem(),
            sb15,
            Container(
              width: Get.width,
              decoration: Shadow1(),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Metode Pembayaran"),
                    sb10,
                    DropdownSearch<String>(
                      popupProps: PopupProps.dialog(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                      ),
                      items: [
                        "Cash",
                        "Transfer",
                      ],
                      onChanged: (value) {
                        print(value);
                      },
                      selectedItem: "Cash",
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
        bottomNavigationBar: Container(
          decoration: Shadow1(),
          alignment: Alignment.bottomCenter,
          height: Get.height * 0.08,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total harga:"),
                      Text(
                        "Rp 200.000",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Beli"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFE49542))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final controller = Get.find<CartController>();
  final itemC = Get.find<ItemController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.4,
      decoration: Shadow1(),
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("12 Sep 2021, 13.21"),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Stok: 20"),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print("delete");
                      },
                      child: GestureDetector(
                        onTap: () {
                          print("delete");
                        },
                        child: Icon(
                          Icons.delete,
                          size: Get.width * 0.04,
                          color: Colors.red.shade800,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: constraints.maxHeight - 65,
                        width: constraints.maxHeight - 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://picsum.photos/200/300",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        flex: 7,
                        child: Container(
                          height: constraints.maxHeight - 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sembako"),
                                  Text(
                                    "Kopi Sachet 3in1 Instant Coffee Mocca",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Harga"),
                                      Text(
                                        "12.000",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          itemC.decrement();
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: Colors.orange.shade300,
                                        ),
                                      ),
                                      Obx(() => Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey))),
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth * 0.15,
                                          child: Text(
                                            itemC.count.value.toString(),
                                            style: TextStyle(fontSize: 18),
                                          ))),
                                      GestureDetector(
                                        onTap: () {
                                          itemC.increment();
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
