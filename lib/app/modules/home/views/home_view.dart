// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/controllers/product_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';
import '../../widgets/main_appbar.dart';
import '../controllers/home_controller.dart';
import './widgets/fitur_item.dart';
import './widgets/info_item.dart';
import './widgets/product_item.dart';
import '../../widgets/bottom_menu.dart';

class HomeView extends GetView {
  final authC = Get.find<AuthController>();
  final homeC = Get.put(HomeController(), permanent: true);
  final productC = Get.put(MainProductController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        // backgroundColor: Colors.blue,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: DefaultAppBar(
            pageTitle: "home",
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => homeC.getInitialData(),
          child: ListView(
            children: [
              Stack(
                children: [
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Container(
                          height: authC.isAuth.value ? 130 : 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                          child: SizedBox()),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        // Username dan QR Code
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => authC.isAuth.value
                                ? GestureDetector(
                                    onTap: () async {
                                      Get.toNamed(Routes.PROFILE);
                                    },
                                    child: homeC.isLoading.value
                                        ? SizedBox()
                                        : RichText(
                                            text: TextSpan(
                                                text: "Halo, ",
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${homeC.name.value}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                                style: TextStyle(fontSize: 20)),
                                          ),
                                  )
                                : SizedBox(
                                    height: 25,
                                  )),
                            Obx(() => authC.isAuth.value
                                ? ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.QRCODE);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[800]),
                                    child: Row(
                                      children: [
                                        Text(
                                          "QR Code",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.qr_code,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 25,
                                  ))
                          ],
                        ),
                      ),
                      //Info cepat
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 10),
                            child: Container(
                              // height: Get.width * 0.33,
                              child: Obx(
                                () => authC.isAuth.value
                                    ? InfoCepat()
                                    : LoginPanel(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //Kabar terkini
              if (false)
                Column(
                  children: [
                    sb20,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: PanelTitle(title: "Kabar terkini"),
                          ),
                          sb15,
                          Container(
                            height: 150,
                            child: ListView.separated(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, int) {
                                return SizedBox(
                                  width: 0,
                                );
                              },
                              itemBuilder: (context, int) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: TextButton(
                                    onPressed: () {
                                      print("kabar");
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(0))),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Container(
                                            height: 150,
                                            width: 210,
                                            child: Image.asset(
                                              "assets/images/kabar-1.jpg",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Judul Berita ${int + 1}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                width: 180,
                                                child: Text(
                                                  "Lorep ipsum dolores semper nue adibu. Lorep ipsum dolores semper nue adibu. Lorep ipsum dolores semper nue adibu. Lorep ipsum dolores semper nue adibu. ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                "Selengkapnya",
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]),
                  ],
                ),
              sb20,
              // Fitur menu
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PanelTitle(title: "Fitur"),
                    sb15,
                    Row(
                      children: [
                        Expanded(
                          child: FiturItem(
                              imgUrl: "add-user",
                              text1: "Token",
                              text2: "Baru",
                              todo: () {
                                if (homeC.settings != null)
                                  Get.toNamed(Routes.NEWTOKEN);
                              }),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: FiturItem(
                                imgUrl: "topup",
                                text1: "Top Up",
                                text2: "Saldo",
                                todo: () {
                                  Get.toNamed(Routes.TOPUP);
                                })),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: FiturItem(
                                imgUrl: "withdraw",
                                text1: "Withdraw",
                                text2: "Dana",
                                todo: () {
                                  if (homeC.balance.value == 0) {
                                    Get.snackbar("Saldo kosong",
                                        "Anda tidak memiliki saldo atau data saldo anda sedang dimuat");
                                  } else {
                                    Get.toNamed(Routes.WITHDRAWAL);
                                  }
                                })),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: FiturItem(
                                imgUrl: "riwayat",
                                text1: "Riwayat",
                                text2: "Cashback",
                                todo: () {})),
                      ],
                    ),
                    sb15,
                    Row(
                      children: [
                        Expanded(
                          child: FiturItem(
                              imgUrl: "transfer",
                              text1: "Transfer",
                              text2: "Dana",
                              todo: () {
                                Get.toNamed(Routes.BALANCETRANSFER);
                              }),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: FiturItem(
                              imgUrl: "modal",
                              text1: "Tanam",
                              text2: "Modal",
                              todo: () {
                                Get.toNamed(Routes.INVESTMENT);
                              }),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: FiturItem(
                              imgUrl: "sampah",
                              text1: "Bank",
                              text2: "Sampah",
                              todo: () {
                                Get.toNamed(Routes.TRASHBANK);
                              }),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: FiturItem(
                              imgUrl: "tagihan",
                              text1: "Listrik",
                              text2: "& Pulsa",
                              todo: () {
                                Get.toNamed(Routes.PPOB);
                              }),
                        ),
                      ],
                    ),
                    sb15,
                    sb15,
                    PanelTitle(title: "Produk Terlaris"),
                  ],
                ),
              ),
              // Produk Terkini
              Obx(() => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 45 / 100,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    itemCount: getAllActiveProducts().length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ProductItem(
                        id: getAllActiveProducts()[index]["id"],
                        name: getAllActiveProducts()[index]["name"],
                        price: getAllActiveProducts()[index]["sell_price"],
                        cashback: getAllActiveProducts()[index]["bagian"][0],
                        stock: getAllActiveProducts()[index]["stockQty"],
                        imgurl: getAllActiveProducts()[index]["imgurl"],
                      );
                    },
                    // to disable GridView's scrolling
                    shrinkWrap: true, // You won't see infinite size error
                  )),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(
          context: context,
          menu1: true,
          menu2: false,
          menu3: false,
          menu4: false,
        ),
      ),
    );
  }

  List<dynamic> getAllActiveProducts() =>
      productC.products.where((p0) => p0["active"]).toList();
}

class InfoCepat extends StatelessWidget {
  const InfoCepat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: InfoItem(
                            imgUrl: "saldo",
                            title: "Saldo",
                            content:
                                "Rp ${NumberFormat("#,##0", "id_ID").format(controller.balance.value)}",
                          ),
                        ),
                        sb10,
                        Container(
                          child: InfoItem(
                            imgUrl: "cashback",
                            title: "Cashback",
                            content:
                                "Rp ${NumberFormat("#,##0", "id_ID").format(controller.cashback.value)}",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.08),
                          child: Text(
                            DateFormat.yMMMM('id_ID').format(DateTime.now()),
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: InfoItem(
                            imgUrl: "anggota",
                            title: "Anggota",
                            content:
                                "${controller.anggota.value.toString()} orang",
                          ),
                        ),
                        sb10,
                        Container(
                          child: InfoItem(
                            imgUrl: "kd",
                            title: "Kedalaman",
                            content: "KD${controller.kd.value.toString()}",
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class LoginPanel extends StatelessWidget {
  final c = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("Anggota mohon login terlebih dahulu"),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                c.isAuth.toggle();
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}
