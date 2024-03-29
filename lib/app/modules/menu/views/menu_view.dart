import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/constants.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/menu_controller.dart' as menu;

class MenuView extends GetView<menu.MenuController> {
  MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    String name = "";
    if (authC.userCredential.value != null) {
      name = authC.userCredential.value!.displayName!;
    }

    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Color(0xFFF4F4F4),
          appBar: AppBar(
            title: const Text(
              'Menu Utama',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Color(0xFFF4F4F4),
            centerTitle: true,
            elevation: 1,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              ListTile(
                horizontalTitleGap: 10,
                onTap: () {
                  Get.offAndToNamed(Routes.PROFILE);
                },
                leading: CircleAvatar(
                  backgroundImage: authC.imgurl.isNotEmpty
                      ? CachedNetworkImageProvider(authC.imgurl.value)
                      : CachedNetworkImageProvider(PROFILE_IMG),
                ),
                title: PanelTitle(title: name),
                subtitle: Text("Referral ID: ${authC.refId.value}"),
                trailing: IconButton(
                  icon: Icon(Icons.logout_rounded),
                  onPressed: () async {
                    await authC.logout();
                  },
                ),
              ),
              Divider(),
              ListTile(
                horizontalTitleGap: 0,
                leading: Icon(Icons.wallet),
                title: Text("Saldo Belanja"),
                subtitle: Text(
                  "Rp ${NumberFormat("#,##0", "id_ID").format(authC.balance.value)}",
                  style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              ListTile(
                horizontalTitleGap: 0,
                leading: Icon(Icons.percent),
                title: Text("Cashback"),
                subtitle: Text(
                  "Rp ${NumberFormat("#,##0", "id_ID").format(authC.cashback.value)}",
                  style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  Get.offNamed(Routes.QRCODE);
                },
                leading: Icon(Icons.qr_code),
                title: Text("Buka QR Code"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                leading: Icon(Icons.edit_note),
                title: Text("Ubah Data Diri"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: PanelTitle(title: "Anggota"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  Get.toNamed(Routes.NEWTOKEN);
                },
                leading: Icon(Icons.add_circle),
                title: Text("Tambah Token"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  Get.offNamed(Routes.MEMBERS);
                },
                leading: Icon(Icons.people_rounded),
                title: Text("Daftar Anggota"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  Get.offNamed(Routes.MEMBERHISTORY);
                },
                leading: Icon(Icons.history),
                title: Text("Riwayat Anggota"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: PanelTitle(title: "Belanja"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {},
                leading: Icon(Icons.list),
                title: Text("Tagihan"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {},
                leading: Icon(Icons.history_edu),
                title: Text("Riwayat Belanja"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {},
                leading: Icon(Icons.delivery_dining),
                title: Text("Pesanan Aktif"),
              ),
              Divider(),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {},
                leading: Icon(Icons.info),
                title: Text("Tentang Aplikasi"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () {},
                leading: Icon(Icons.help_center),
                title: Text("Bantuan"),
              ),
              ListTile(
                horizontalTitleGap: 0,
                onTap: () async {
                  await authC.logout();
                },
                leading: Icon(Icons.logout_rounded),
                title: Text("Keluar"),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => controller.setVersion(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "© Kober Bali Jaya ${DateFormat.y().format(DateTime.now())}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Obx(() => Text(
                          "v" + controller.appVersion.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }
}
