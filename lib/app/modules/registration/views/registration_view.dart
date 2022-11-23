// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobermart_client/app/modules/home/controllers/home_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/registration_controller.dart';

import 'dart:io';

class RegistrationView extends GetView<RegistrationController> {
  RegistrationView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();

  ImagePicker imagePicker = ImagePicker();

  void selectImage() async {
    final XFile? selectedImages = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 50);

    controller.imageFileList.clear();
    controller.imageFileList.add(selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    String tokenCode = "8812391239";

    if (Get.arguments != null) {
      tokenCode = Get.arguments["tokenCode"];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getProvinceData(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sb15,
              Center(child: PanelTitle(title: "Token ${tokenCode}")),
              sb15,
              Obx(
                () => Container(
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  child: controller.imageFileList.value.isEmpty
                      ? CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: Get.width * 0.12,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                              File(controller.imageFileList.last!.path)),

                          // CachedNetworkImageProvider("https://i.pravatar.cc/150"),
                        ),
                ),
              ),
              TextButton(
                onPressed: () {
                  selectImage();
                },
                child: Text("Pilih gambar"),
              ),
              PanelIdentitasDiri(),
              sb15,
              Obx(() => controller.provList.isEmpty
                  ? PanelAlamat()
                  : PanelAlamatAPI()),
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
              Obx(
                () => Container(
                  width: Get.width - 30,
                  child: ElevatedButton(
                    child: controller.isLoading.value
                        ? Container(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text("Kirim"),
                    onPressed: () async {
                      await controller.setMember(tokenCode).then((value) async {
                        if (devMode) print(value.body);
                        if (value.body["success"] == false) {
                          Get.defaultDialog(
                              title: "Registrasi Gagal",
                              content: Container(
                                height: 100,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        value.body["error_msg"].length,
                                        (index) => Text(
                                            "${index + 1}. ${value.body["error_msg"][index]}")),
                                  ),
                                ),
                              ));
                        } else {
                          controller.isLoading.value = true;
                          await homeC.getInitialData().then((value) {
                            Get.snackbar("Registrasi berhasil!",
                                "Anggota baru berhasil didaftarkan");
                            Get.offAllNamed(Routes.HOME);
                          });
                          controller.isLoading.value = false;
                        }
                      });
                    },
                  ),
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
      ),
    );
  }
}

class PanelIdentitasDiri extends StatelessWidget {
  PanelIdentitasDiri({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                title: "Nama Lengkap",
                symbol: "*",
              ),
              sb5,
              TextField(
                controller: controller.name,
                autofillHints: [AutofillHints.name, AutofillHints.name],
                decoration: InputDecoration(
                  hintText: "Nama lengkap",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.nameError.value
                            ? Colors.red
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),

              sb15,
              // Tanggal lahir dan bulan
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
                          controller: controller.day,
                          keyboardType: TextInputType.number,
                          autofillHints: [AutofillHints.birthdayDay],
                          decoration: InputDecoration(
                            hintText: "cth: 11",
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: controller.dayError.value
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                          title: "Bulan Lahir",
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
                              "Januari",
                              "Februari",
                              "Maret",
                              "April",
                              "Mei",
                              "Juni",
                              "Juli",
                              "Agustus",
                              "September",
                              "Oktober",
                              "November",
                              "Desember",
                            ],
                            onChanged: (value) {
                              switch (value) {
                                case "Januari":
                                  controller.month.text = "01";
                                  break;
                                case "Februari":
                                  controller.month.text = "02";
                                  break;
                                case "Maret":
                                  controller.month.text = "03";
                                  break;
                                case "April":
                                  controller.month.text = "04";
                                  break;
                                case "Mei":
                                  controller.month.text = "05";
                                  break;
                                case "Juni":
                                  controller.month.text = "06";
                                  break;
                                case "Juli":
                                  controller.month.text = "07";
                                  break;
                                case "Agustus":
                                  controller.month.text = "08";
                                  break;
                                case "September":
                                  controller.month.text = "09";
                                  break;
                                case "Oktober":
                                  controller.month.text = "10";
                                  break;
                                case "November":
                                  controller.month.text = "11";
                                  break;
                                case "Desember":
                                  controller.month.text = "12";
                                  break;
                                default:
                                  controller.month.text = "01";
                              }
                              if (devMode) print(controller.month.text);
                            },
                            selectedItem: "Januari",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sb15,
              // Tahun lahir dan jenis kelamin
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldLabelText(
                          title: "Tahun Lahir",
                          symbol: "*",
                        ),
                        sb5,
                        TextField(
                          controller: controller.year,
                          keyboardType: TextInputType.number,
                          autofillHints: [AutofillHints.birthdayYear],
                          decoration: InputDecoration(
                            hintText: "cth: 1990",
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: controller.yearError.value
                                      ? Colors.red
                                      : Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                              switch (value) {
                                case "Pria":
                                  controller.gender.value = "male";
                                  break;
                                case "Wanita":
                                  controller.gender.value = "female";
                                  break;
                                default:
                                  controller.gender.value = "male";
                              }
                            },
                            selectedItem: "pilih",
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
      ),
    );
  }
}

class PanelAlamat extends StatelessWidget {
  PanelAlamat({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                controller: controller.jalan,
                autofillHints: [
                  AutofillHints.streetAddressLine1,
                  AutofillHints.fullStreetAddress
                ],
                decoration: InputDecoration(
                  hintText: "Nama jalan/banjar",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.jalanError.value
                            ? Colors.red
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              sb15,
              FieldLabelText(
                title: "Desa",
                symbol: "*",
              ),
              sb5,
              TextField(
                controller: controller.desa,
                autofillHints: [AutofillHints.streetAddressLine2],
                decoration: InputDecoration(
                  hintText: "Desa/Kelurahan",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.desaError.value
                            ? Colors.red
                            : Colors.grey),
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
                          title: "Kecamatan",
                          symbol: "*",
                        ),
                        sb5,
                        TextField(
                          controller: controller.kec,
                          decoration: InputDecoration(
                            hintText: "Kecamatan",
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: controller.kecError.value
                                      ? Colors.red
                                      : Colors.grey),
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
                          controller: controller.kab,
                          autofillHints: [AutofillHints.addressCity],
                          decoration: InputDecoration(
                            hintText: "Kabupaten",
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: controller.kabError.value
                                      ? Colors.red
                                      : Colors.grey),
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
                          controller: controller.prov,
                          autofillHints: [AutofillHints.addressState],
                          decoration: InputDecoration(
                            hintText: "Provinsi",
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: controller.provError.value
                                      ? Colors.red
                                      : Colors.grey),
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
                          controller: controller.kodepos,
                          autofillHints: [AutofillHints.postalCode],
                          keyboardType: TextInputType.number,
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
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PanelKontak extends StatelessWidget {
  PanelKontak({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                controller: controller.whatsapp,
                autofillHints: [AutofillHints.telephoneNumber],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Cth. 081805123123",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.whatsappError.value
                            ? Colors.red
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              sb15,
              FieldLabelText(
                title: "Email",
                symbol: "*",
              ),
              sb5,
              TextField(
                controller: controller.email,
                autofillHints: [AutofillHints.email],
                decoration: InputDecoration(
                  hintText: "cth. nama@gmail.com",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.emailError.value
                            ? Colors.red
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PanelRekening extends StatelessWidget {
  PanelRekening({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegistrationController>();

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
              controller: controller.bank,
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
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            sb15,
            FieldLabelText(
              title: "No Rekening",
              symbol: "",
            ),
            sb5,
            TextField(
              controller: controller.rek,
              keyboardType: TextInputType.number,
              autofillHints: [AutofillHints.creditCardNumber],
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

class PanelKeamanan extends StatelessWidget {
  PanelKeamanan({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
                controller: controller.password,
                autofillHints: [AutofillHints.password],
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password anda",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.passwordError.value
                            ? Colors.red
                            : Colors.grey),
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
                controller: controller.passwordConf,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Ulangi Password anda",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.passwordConfError.value
                            ? Colors.red
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
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

class PanelAlamatAPI extends StatelessWidget {
  PanelAlamatAPI({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width,
        decoration: Shadow1(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PanelTitle(title: "Alamat"),
                  Text(
                    "API Online",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              sb10,
              FieldLabelText(
                title: "Daerah/Provinsi",
                symbol: "*",
              ),
              sb5,
              Container(
                height: 40,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.modalBottomSheet(
                      fit: FlexFit.loose,
                      showSelectedItems: true,
                      title: Center(child: Text("Pilih Daerah/Provinsi"))),
                  items: List.generate(controller.provList.value.length,
                      (index) => controller.provList.value[index]["name"]),
                  onChanged: (value) async {
                    // clear another list
                    controller.kabList.clear();
                    controller.kab.text = "";
                    controller.kecList.clear();
                    controller.kec.text = "";
                    controller.desaList.clear();
                    controller.desa.text = "";

                    controller.prov.text = value!;
                    var id;
                    controller.provList.forEach((e) {
                      if (e["name"] == value) {
                        id = e["id"];
                        controller.selectedProv.value = e["name"];
                      }
                    });
                    if (devMode) print(controller.selectedProv.value);
                    await GetConnect()
                        .get("${controller.url}regencies/${id}.json")
                        .then((value) {
                      controller.kabList.value = value.body;
                      controller.kab.text = controller.kabList[0]["name"];
                    });
                  },
                  selectedItem: controller.provList[0]["name"],
                ),
              ),
              if (controller.kabList.isNotEmpty) sb15,
              if (controller.kabList.isNotEmpty)
                FieldLabelText(
                  title: "Kabupaten",
                  symbol: "*",
                ),
              if (controller.kabList.isNotEmpty) sb5,
              if (controller.kabList.isNotEmpty)
                Container(
                  height: 40,
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.modalBottomSheet(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        title: Center(child: Text("Pilih Kabupaten"))),
                    items: List.generate(controller.kabList.value.length,
                        (index) => controller.kabList.value[index]["name"]),
                    onChanged: (value) async {
                      // clear another list
                      controller.kecList.clear();
                      controller.kec.text = "";
                      controller.desaList.clear();
                      controller.desa.text = "";

                      controller.kab.text = value!;
                      var id;
                      controller.kabList.forEach((e) {
                        if (e["name"] == value) {
                          id = e["id"];
                          controller.selectedKab.value = e["name"];
                        }
                      });
                      if (devMode) print(controller.selectedKab.value);
                      await GetConnect()
                          .get("${controller.url}districts/${id}.json")
                          .then((value) {
                        controller.kecList.value = value.body;
                        controller.kec.text = controller.kecList[0]["name"];
                      });
                    },
                    selectedItem: controller.kabList[0]["name"],
                  ),
                ),
              if (controller.kecList.isNotEmpty) sb15,
              if (controller.kecList.isNotEmpty)
                FieldLabelText(
                  title: "Kecamatan",
                  symbol: "*",
                ),
              if (controller.kecList.isNotEmpty) sb5,
              if (controller.kecList.isNotEmpty)
                Container(
                  height: 40,
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.modalBottomSheet(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        title: Center(child: Text("Pilih Kecamatan"))),
                    items: List.generate(controller.kecList.value.length,
                        (index) => controller.kecList.value[index]["name"]),
                    onChanged: (value) async {
                      // clear another list
                      controller.desaList.clear();
                      controller.desa.text = "";

                      controller.kec.text = value!;
                      var id;
                      controller.kecList.forEach((e) {
                        if (e["name"] == value) {
                          id = e["id"];
                          controller.selectedKec.value = e["name"];
                        }
                      });
                      if (devMode) print(controller.selectedKec.value);
                      await GetConnect()
                          .get("${controller.url}villages/${id}.json")
                          .then((value) {
                        controller.desaList.value = value.body;
                        controller.desa.text = controller.desaList[0]["name"];
                      });
                    },
                    selectedItem: controller.kecList[0]["name"],
                  ),
                ),
              if (controller.desaList.isNotEmpty) sb15,
              if (controller.desaList.isNotEmpty)
                FieldLabelText(
                  title: "Desa",
                  symbol: "*",
                ),
              if (controller.desaList.isNotEmpty) sb5,
              if (controller.desaList.isNotEmpty)
                Container(
                  height: 40,
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.modalBottomSheet(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        title: Center(child: Text("Pilih Desa"))),
                    items: List.generate(controller.desaList.value.length,
                        (index) => controller.desaList.value[index]["name"]),
                    onChanged: (value) async {
                      controller.desa.text = value!;
                      controller.desaList.forEach((e) {
                        if (e["name"] == value) {
                          controller.selectedDesa.value = e["name"];
                        }
                      });
                      if (devMode) print(controller.selectedDesa.value);
                    },
                    selectedItem: controller.desaList[0]["name"],
                  ),
                ),
              sb15,
              FieldLabelText(
                title: "Nama jalan/banjar",
                symbol: "*",
              ),
              sb5,
              TextField(
                controller: controller.jalan,
                autofillHints: [
                  AutofillHints.streetAddressLine1,
                  AutofillHints.fullStreetAddress
                ],
                decoration: InputDecoration(
                  hintText: "Nama jalan/banjar",
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: controller.jalanError.value
                            ? Colors.red
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
