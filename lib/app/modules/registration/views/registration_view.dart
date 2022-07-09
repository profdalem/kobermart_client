import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sb15,
            Center(child: PanelTitle(title: "Token 8812391239")),
            sb15,
            Container(
              height: Get.width * 0.2,
              width: Get.width * 0.2,
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Pilih gambar"),
            ),
            PanelIdentitasDiri(),
            sb15,
            PanelAlamat(),
            sb15,
            PanelKontak(),
            sb15,
            PanelRekening(),
            sb15,
            PanelKeamanan(),
            sb10,
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "*wajib diisi",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            sb20,
            Container(
              width: Get.width - 30,
              child: ElevatedButton(
                child: Text("Kirim"),
                onPressed: () {},
              ),
            ),
            Container(
              width: Get.width - 30,
              child: TextButton(
                child: Text("Batalkan"),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            sb20
          ],
        ),
      ),
    );
  }
}

class PanelKeamanan extends StatelessWidget {
  const PanelKeamanan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: Shadow1(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(title: "Keamanan"),
            sb10,
            FieldLabelText(
              title: "Password",
              symbol: "*",
            ),
            sb5,
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password anda",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            sb15,
            FieldLabelText(
              title: "Ulangi password",
              symbol: "*",
            ),
            sb5,
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Ulangi Password anda",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PanelRekening extends StatelessWidget {
  const PanelRekening({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: Shadow1(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(title: "Rekening"),
            sb10,
            FieldLabelText(
              title: "Bank",
              symbol: "",
            ),
            sb5,
            TextField(
              decoration: InputDecoration(
                hintText: "Nama Bank",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            sb15,
            FieldLabelText(
              title: "No Rekening",
              symbol: "",
            ),
            sb5,
            TextField(
              decoration: InputDecoration(
                hintText: "No Rekening",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PanelKontak extends StatelessWidget {
  const PanelKontak({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: Shadow1(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(title: "Kontak"),
            sb10,
            FieldLabelText(
              title: "No Tlp/Whatsapp",
              symbol: "*",
            ),
            sb5,
            TextField(
              decoration: InputDecoration(
                hintText: "Cth. 081805123123",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            sb15,
            FieldLabelText(
              title: "Email",
              symbol: "*",
            ),
            sb5,
            TextField(
              decoration: InputDecoration(
                hintText: "cth. nama@gmail.com",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PanelAlamat extends StatelessWidget {
  const PanelAlamat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: Shadow1(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(title: "Alamat"),
            sb10,
            FieldLabelText(
              title: "Nama jalan/banjar",
              symbol: "*",
            ),
            sb5,
            TextField(
              decoration: InputDecoration(
                hintText: "Nama jalan/banjar",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            sb15,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabelText(
                        title: "Desa/Kelurahan",
                        symbol: "*",
                      ),
                      sb5,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Desa/kelurahan",
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabelText(
                        title: "Kabupaten",
                        symbol: "*",
                      ),
                      sb5,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Kabupaten",
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sb15,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabelText(
                        title: "Provinsi",
                        symbol: "*",
                      ),
                      sb5,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Provinsi",
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabelText(
                        title: "Kode Pos",
                        symbol: "",
                      ),
                      sb5,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Kode Pos",
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PanelIdentitasDiri extends StatelessWidget {
  const PanelIdentitasDiri({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: Shadow1(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(title: "Identitas Diri"),
            sb10,
            FieldLabelText(
              title: "Idenditas Diri",
              symbol: "*",
            ),
            sb5,
            TextField(
              decoration: InputDecoration(
                hintText: "Nama lengkap",
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            sb15,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabelText(
                        title: "Tgl Lahir",
                        symbol: "*",
                      ),
                      sb5,
                      TextField(
                        decoration: InputDecoration(
                          hintText: "cth: 01/01/1990",
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabelText(
                        title: "Jenis Kelamin",
                        symbol: "*",
                      ),
                      sb5,
                      Container(
                        height: 40,
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.dialog(
                            fit: FlexFit.loose,
                            showSelectedItems: true,
                          ),
                          items: [
                            "Pria",
                            "Wanita",
                          ],
                          onChanged: (value) {
                            print(value);
                          },
                          selectedItem: "Pria",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FieldLabelText extends StatelessWidget {
  const FieldLabelText({
    Key? key,
    required this.title,
    required this.symbol,
  }) : super(key: key);

  final String title;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        children: [
          TextSpan(
            text: symbol,
            style: TextStyle(color: Colors.red),
          )
        ],
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
