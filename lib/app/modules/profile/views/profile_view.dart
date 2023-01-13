import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sb15,
            sb15,
            Container(
                width: Get.width * 0.2,
                height: Get.width * 0.2,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(authC.imgurl.value),
                )),
            TextButton(onPressed: () {}, child: Text("ubah gambar")),
            sb15,
            Container(
              width: Get.width,
              child: Card(
                  child: ListTile(
                title: Text(Auth.currentUser!.displayName!),
                subtitle: Text("Nama"),
                trailing: Text(
                  "ubah",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ),
            Container(
              width: Get.width,
              child: Card(
                  child: ListTile(
                title: Text(Auth.currentUser!.email!),
                subtitle: Text("Email"),
                trailing: Text(
                  "ubah",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ),
            Container(
              width: Get.width,
              child: Card(
                  child: ListTile(
                title: Text("085313924122"),
                subtitle: Text("No Telepon"),
                trailing: Text(
                  "ubah",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ),
            Container(
              width: Get.width,
              child: Card(
                  child: ListTile(
                title: Text("Jalan Raya Peslakan, Kecamatan Tampaksiring, Kabupaten Gianyar, Bali 80552"),
                subtitle: Text("Alamat"),
                trailing: Text(
                  "ubah",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ),
            Container(
              width: Get.width,
              child: Card(
                  child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("BCA"),
                    Text("12345678901"),
                  ],
                ),
                subtitle: Text("Rekening"),
                trailing: Text(
                  "ubah",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ),
            sb15,
            Container(width: Get.width, padding: EdgeInsets.only(left: 15), alignment: Alignment.centerLeft, child: PanelTitle(title: "Keamanan")),
            sb5,
            Container(
              width: Get.width,
              child: Card(
                  child: ListTile(
                title: Text("******"),
                subtitle: Text("Password"),
                trailing: Text(
                  "ubah",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ),
            sb10,
          ],
        ),
      ),
    );
  }
}
