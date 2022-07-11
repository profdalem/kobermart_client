import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/modules/shop/views/widgets/product_item.dart';
import 'package:kobermart_client/style.dart';
import '../../widgets/bottom_menu.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: DefaultAppBar(
            pageTitle: "Belanja",
          ),
        ),
        body: ListView(
            padding: EdgeInsets.only(left: 0, right: 0, top: 15),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    CariButton(),
                    SizedBox(
                      width: 10,
                    ),
                    UrutkanButton(),
                  ],
                ),
              ),
              sb15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Kategori"),
              ),
              sb15,
              Container(
                height: MediaQuery.of(context).size.width * 0.22,
                child: ListView.separated(
                    padding: EdgeInsets.only(left: 15, top: 3, bottom: 3),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int numbers) {
                      return SizedBox(width: 10);
                    },
                    itemBuilder: ((context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                              elevation: MaterialStateProperty.all(3),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            print(index);
                          },
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/cat-kebun.svg",
                                fit: BoxFit.scaleDown,
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Kategori ${index + 1}",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                        ),
                      );
                    })),
              ),
              sb15,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Produk Terlaris"),
              ),
              sb15,
              // Produk Terlaris
              ProductHorizontalList(),
              sb20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PanelTitle(title: "Semua Troduk"),
              ),
              sb15,
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 52 / 100,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                itemCount: 10,
                itemBuilder: (BuildContext ctx, int index) {
                  return ProductItem(
                    name: "Barang",
                    price: 12000,
                    cashback: 2,
                    stock: 50,
                  );
                },
                // to disable GridView's scrolling
                shrinkWrap: true, // You won't see infinite size error
              ),
            ]),
        bottomNavigationBar: BottomNav(
          context: context,
          menu1: false,
          menu2: true,
          menu3: false,
          menu4: false,
        ),
      ),
    );
  }
}

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 15),
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: 150,
          child: ProductItem(
            name: "Product ${index}",
            price: 20000,
            cashback: 5,
            stock: 50,
          ),
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
    return TextButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              "Cari",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 3,
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
    );
  }
}

class UrutkanButton extends StatelessWidget {
  const UrutkanButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            height: 300,
            child: Column(
              children: [],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
          ),
          isDismissible: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
          enableDrag: false,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              "Urutkan",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.sort,
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
    );
  }
}
