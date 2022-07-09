import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  const MenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
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
                onTap: () {
                  Get.offAndToNamed(Routes.PROFILE);
                },
                leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        "https://i.pravatar.cc/150?img=1")),
                title: PanelTitle(title: "Username 1"),
                subtitle: Text("Referal ID: Username"),
                trailing: IconButton(
                  icon: Icon(Icons.logout_rounded),
                  onPressed: () {
                    authC.logout();
                  },
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.wallet),
                title: Text("Saldo Belanja"),
                subtitle: Text(
                  "Rp 1.750.000,-",
                  style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              ListTile(
                leading: Icon(Icons.percent),
                title: Text("Cashback"),
                subtitle: Text(
                  "Rp 1.750.000,-",
                  style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.offNamed(Routes.QRCODE);
                },
                leading: Icon(Icons.qr_code),
                title: Text("Buka QR Code"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.edit_note),
                title: Text("Ubah Data Diri"),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: PanelTitle(title: "Anggota"),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.NEWTOKEN);
                },
                leading: Icon(Icons.add_circle),
                title: Text("Tambah Token"),
              ),
              ListTile(
                onTap: () {
                  Get.offNamed(Routes.MEMBERS);
                },
                leading: Icon(Icons.people_rounded),
                title: Text("Daftar Anggota"),
              ),
              ListTile(
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
                onTap: () {},
                leading: Icon(Icons.list),
                title: Text("Tagihan"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.history_edu),
                title: Text("Riwayat Belanja"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.delivery_dining),
                title: Text("Pesanan Aktif"),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.info),
                title: Text("Tentang Aplikasi"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.help_center),
                title: Text("Bantuan"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.logout_rounded),
                title: Text("Keluar"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "© Kober Bali Jaya 2022",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }
}
