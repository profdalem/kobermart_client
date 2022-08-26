import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/product_controller.dart';
import 'package:kobermart_client/app/modules/cart/controllers/item_controller.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  CartView({Key? key}) : super(key: key);

  final productC = Get.find<MainProductController>();
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
            Obx(() => productC.carts.isEmpty
                ? Center(child: Text("Kosong"))
                : Column(
                    children: List.generate(
                        productC.carts.length,
                        (index) => Column(
                              children: [CartItem(index), sb15],
                            )),
                  )),
            if (productC.carts.isNotEmpty)
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
        bottomNavigationBar: Obx(() => productC.carts.isEmpty
            ? SizedBox()
            : Container(
                decoration: Shadow1(),
                alignment: Alignment.bottomCenter,
                height: Get.height * 0.1,
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
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      symbol: "Rp ",
                                      decimalDigits: 0)
                                  .format(controller.totalprice.value),
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
              )),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final controller = Get.find<CartController>();
  final itemC = Get.find<ItemController>();
  final productC = Get.find<MainProductController>();

  CartItem(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    itemC.count.value = productC.carts[index]["cartItem"]["qty"];
    itemC.price.value = productC.carts[index]["cartItem"]["deal_price"];
    itemC.id = productC.carts[index]["cartItem"]["id"];
    itemC.stock = productC.carts[index]["stockQty"];

    controller.totalprice.value += (itemC.count.value * itemC.price.value);

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
                        Text(
                            "Stok: ${productC.carts[index]["stockQty"].toString()}"),
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
                        height: constraints.maxHeight - 70,
                        width: constraints.maxHeight - 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
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
                          height: constraints.maxHeight - 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productC.carts[index]["categoryDetail"]
                                            ["title"]
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    productC.carts[index]["productDetail"]
                                        ["name"],
                                    style: TextStyle(
                                        fontSize: 14,
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
                                      Text(
                                        "Harga satuan",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: "id_ID",
                                                symbol: "Rp ",
                                                decimalDigits: 0)
                                            .format(productC.carts[index]
                                                ["cartItem"]["deal_price"]),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() => GestureDetector(
                                                onTap: () {
                                                  itemC.decrement();
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: itemC.count.value == 0
                                                      ? Colors.grey.shade300
                                                      : Colors.orange.shade300,
                                                  size: 18,
                                                ),
                                              )),
                                          Obx(() => Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey))),
                                              alignment: Alignment.center,
                                              width:
                                                  constraints.maxWidth * 0.15,
                                              child: Text(
                                                productC.carts[index]
                                                        ["cartItem"]["qty"]
                                                    .toString(),
                                                style: TextStyle(fontSize: 14),
                                              ))),
                                          Obx(() => GestureDetector(
                                                onTap: () {
                                                  itemC.increment();
                                                },
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: itemC.count.value ==
                                                          itemC.stock
                                                      ? Colors.grey.shade300
                                                      : Colors.green.shade700,
                                                  size: 18,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text("Total: "),
                                          Obx(() => Text(
                                                NumberFormat.currency(
                                                        locale: "id_ID",
                                                        symbol: "Rp ",
                                                        decimalDigits: 0)
                                                    .format(itemC.count.value *
                                                        itemC.price.value),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
