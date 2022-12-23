import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/digitalproducts_controller.dart';

class DigitalproductsView extends GetView<DigitalproductsController> {
  const DigitalproductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 15, bottom: 15, top: 20),
            child: PanelTitle(title: "Pilih produk"),
          ),
          Expanded(
            child: ListView(
              children: List.generate(controller.products.length, (index) => Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: ListTile(
                    onTap: controller.products[index]["action"],
                  leading: CircleAvatar(child: controller.products[index]["icon"], backgroundColor: controller.products[index]["icon_bg"],),
                  title: Text(controller.products[index]["name"], style: TextStyle(fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
                ),)),
            ),
          ),
        ],
      ),
    );
  }
}
