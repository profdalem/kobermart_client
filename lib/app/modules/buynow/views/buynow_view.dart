import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/widgets/sucess_buynow.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/buynow_controller.dart';

class BuynowView extends GetView<BuynowController> {
  const BuynowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Langsung Beli'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              sb15,
              Container(
                decoration: Shadow1(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tersedia: 120"),
                          Text("12.21 WITA - 12 Sep 2021"),
                        ],
                      ),
                      sb15,
                      Container(
                        height: Get.width * 0.3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: Get.width * 0.3,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "https://picsum.photos/200/300",
                                          ),
                                          fit: BoxFit.cover)),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Sembako"),
                                      PanelTitle(
                                          title:
                                              "Kopi Sachet 3in1 Instant Coffee Mocca "),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Harga satuan"),
                                      Text(
                                        "Rp 12.000",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sb10,
                          Text(
                            "Bagian",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              BagianAnggota(
                                bg: "Anggota:",
                                nominal: 3,
                              ),
                              BagianAnggota(
                                bg: "KD1:",
                                nominal: 1,
                              ),
                              BagianAnggota(
                                bg: "KD2:",
                                nominal: 1,
                              ),
                              BagianAnggota(
                                bg: "KD3:",
                                nominal: 1,
                              ),
                              BagianAnggota(
                                bg: "KD4:",
                                nominal: 1,
                              ),
                              BagianAnggota(
                                bg: "KD5:",
                                nominal: 1,
                              ),
                            ],
                          ),
                          sb20,
                          Text(
                            "Deskripsi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu tristique turpis turpis duis. Faucibus fermentum, nunc suscipit orci magna nulla pellentesque. Lectus.",
                          ),
                          sb20,
                          Row(
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
                                      size: 30,
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      alignment: Alignment.center,
                                      width: Get.width * 0.2,
                                      child: Text(
                                        "0",
                                        style: TextStyle(fontSize: 25),
                                      )),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.green.shade700,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PanelTitle(title: "Metode Pembayaran"),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: "Saldo: ",
                                  children: [
                                TextSpan(
                                    text: "Rp 2.000.000",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ]))
                        ],
                      ),
                      sb10,
                      DropdownSearch<String>(
                        popupProps: PopupProps.dialog(
                          fit: FlexFit.loose,
                          showSelectedItems: true,
                        ),
                        items: [
                          "Cash",
                          "Transfer",
                          "Potong Saldo",
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
          ),
        ),
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
                    onPressed: () {
                      Get.to(() => SuccessBuynowPage());
                    },
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

class BagianAnggota extends StatelessWidget {
  const BagianAnggota({
    Key? key,
    required this.bg,
    required this.nominal,
  }) : super(key: key);

  final String bg;
  final int nominal;

  @override
  Widget build(BuildContext context) {
    var org = false;
    if (bg == "Anggota:") {
      org = true;
    }
    return Container(
      width: (bg.length + nominal.toString().length + 5).toDouble() * 8,
      decoration: BoxDecoration(
          color: org ? Colors.orange.shade50 : Colors.grey.shade200,
          border: Border.all(
            color: org ? Colors.orange.shade400 : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bg,
              style:
                  TextStyle(color: org ? Colors.orange.shade600 : Colors.black),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${nominal.toString()}%",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: org ? Colors.orange.shade600 : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
