import 'dart:convert';
import 'dart:io';
import 'package:kobermart_client/app/data/member_provider.dart';
import 'package:kobermart_client/config.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobermart_client/firebase.dart';

class RegistrationController extends GetxController {
  String url = "https://www.emsifa.com/api-wilayah-indonesia/api/";
  RxList<XFile?> imageFileList = <XFile?>[].obs;

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController refid;
  late TextEditingController whatsapp;
  late TextEditingController day;
  late TextEditingController month;
  late TextEditingController year;
  late TextEditingController bank;
  late TextEditingController rek;
  late TextEditingController jalan;
  late TextEditingController desa;
  late TextEditingController kec;
  late TextEditingController kab;
  late TextEditingController prov;
  late TextEditingController kodepos;
  late TextEditingController password;
  late TextEditingController passwordConf;

  var nameError = false.obs;
  var emailError = false.obs;
  var whatsappError = false.obs;
  var dayError = false.obs;
  var yearError = false.obs;
  var genderError = false.obs;
  var jalanError = false.obs;
  var desaError = false.obs;
  var kecError = false.obs;
  var kabError = false.obs;
  var provError = false.obs;
  var passwordError = false.obs;
  var passwordConfError = false.obs;

  var gender = "".obs;
  var filename = "".obs;
  var isLoading = false.obs;
  List<String> errorText = [];

  var provList = [].obs;
  var kabList = [].obs;
  var kecList = [].obs;
  var desaList = [].obs;

  var selectedProv = "".obs;
  var selectedKab = "".obs;
  var selectedKec = "".obs;
  var selectedDesa = "".obs;

  @override
  void onInit() {
    name = TextEditingController();
    day = TextEditingController();
    month = TextEditingController();
    year = TextEditingController();
    email = TextEditingController();
    refid = TextEditingController();
    whatsapp = TextEditingController();
    bank = TextEditingController();
    rek = TextEditingController();
    jalan = TextEditingController();
    desa = TextEditingController();
    kec = TextEditingController();
    kab = TextEditingController();
    prov = TextEditingController();
    kodepos = TextEditingController();
    password = TextEditingController();
    passwordConf = TextEditingController();
    if (preFilled) {
      name.text = "Random name";
      day.text = "11";
      year.text = "1990";
      email.text = "hohoho@gmail.com";
      whatsapp.text = "081999222999";
      jalan.text = "Jalan raya pesalakan";
      password.text = "123456";
      passwordConf.text = "123456";
    }

    getProvinceData();

    month.text = "01";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    name.dispose();
    day.dispose();
    month.dispose();
    year.dispose();
    email.dispose();
    refid.dispose();
    whatsapp.dispose();
    bank.dispose();
    rek.dispose();
    jalan.dispose();
    desa.dispose();
    kec.dispose();
    kab.dispose();
    prov.dispose();
    kodepos.dispose();
    password.dispose();
    passwordConf.dispose();
    super.onClose();
  }

  Future<void> getProvinceData() async {
    await GetConnect().get("${url}provinces.json").then((value) {
      provList.value = value.body;
      prov.text = provList[0]["name"];
    });
  }

  Future<Response> setMember(String token) async {
    isLoading.value = true;
    var body;

    errorCheck();

    if (imageFileList.isNotEmpty) {
      filename.value =
          "${token.toString()}-${Timestamp.now().seconds}${p.extension(imageFileList.last!.path)}";

      try {
        profileRef
            .child(filename.value)
            .putFile(File(imageFileList.last!.path))
            .then((result) => print(result));
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    if (errorText.isEmpty) {
      body = json.encode({
        "tokenCode": token,
        "name": name.text,
        "email": email.text,
        "gender": gender.value,
        "day": day.text,
        "month": month.text,
        "year": year.text,
        "whatsapp": whatsapp.text,
        "jalan": jalan.text,
        "desa": desa.text,
        "kec": kec.text,
        "kab": kab.text,
        "prov": prov.text,
        "kodepos": kodepos.text,
        "bank": bank.text,
        "bankAcc": rek.text,
        "password": password.text,
        "passwordConf": passwordConf.text,
        "imgUrl": filename.value
      });

      // if (devMode) print(body);

      var result = await MemberProvider().setMember(body);
      isLoading.value = false;
      return result;
    } else {
      isLoading.value = false;
      Response res = Response(body: {
        "success": false,
        "message": "Result of the function",
        "error_msg": errorText
      });
      return res;
    }
  }

  void cleanError() {
    nameError.value = false;
    emailError.value = false;
    whatsappError.value = false;
    dayError.value = false;
    yearError.value = false;
    genderError.value = false;
    jalanError.value = false;
    desaError.value = false;
    kecError.value = false;
    kabError.value = false;
    provError.value = false;
    passwordError.value = false;
    passwordConfError.value = false;
    errorText.clear();
  }

  void errorCheck() {
    cleanError();

    if (name.text.isEmpty) {
      nameError.value = true;
      errorText.add("Kolom nama tidak boleh kosong");
    }

    if (email.text.isEmpty) {
      emailError.value = true;
      errorText.add("Kolom email tidak boleh kosong");
    } else {
      if (!GetUtils.isEmail(email.text)) {
        emailError.value = true;
        errorText.add("Format email salah");
      }
    }

    if (whatsapp.text.isEmpty) {
      whatsappError.value = true;
      errorText.add("Kolom whatsapp tidak boleh kosong");
    } else {
      if (whatsapp.text.length < 10 || whatsapp.text[0] != "0") {
        whatsappError.value = true;
        errorText.add("Tulis nomor whatsapp sesuai format");
      }
    }

    if (day.text.isEmpty) {
      dayError.value = true;
      errorText.add("Kolom tanggal lahir tidak boleh kosong");
    } else {
      if (int.parse(day.text) < 1 || int.parse(day.text) > 31) {
        dayError.value = true;
        errorText.add("Tanggal harus di rentang 1-31");
      }
    }

    if (year.text.isEmpty) {
      yearError.value = true;
      errorText.add("Kolom tahun lahir tidak boleh kosong");
    } else {
      if (int.parse(year.text) < 1900 ||
          int.parse(year.text) > DateTime.now().year) {
        yearError.value = true;
        errorText.add("Tahun lahir anda salah");
      }
    }

    if (gender.value.isEmpty) {
      genderError.value = true;
      errorText.add("Pilih jenis kelamin terlebih dahulu");
    }

    if (jalan.text.isEmpty) {
      jalanError.value = true;
      errorText.add("Kolom jalan tidak boleh kosong");
    }

    if (desa.text.isEmpty) {
      desaError.value = true;
      errorText.add("Kolom desa tidak boleh kosong");
    }

    if (kec.text.isEmpty) {
      kecError.value = true;
      errorText.add("Kolom kecamatan tidak boleh kosong");
    }

    if (kab.text.isEmpty) {
      kabError.value = true;
      errorText.add("Kolom kabupaten tidak boleh kosong");
    }

    if (prov.text.isEmpty) {
      provError.value = true;
      errorText.add("Kolom provinsi tidak boleh kosong");
    }

    if (password.text.isEmpty) {
      passwordError.value = true;
      errorText.add("Kolom password tidak boleh kosong");
    } else {
      if (password.text.length < 6) {
        passwordError.value = true;
        errorText.add("Password minimal 6 karakter");
      }
    }

    if (passwordConf.text.isEmpty) {
      passwordConfError.value = true;
      errorText.add("Kolom Ulangi password tidak boleh kosong");
    } else {
      if (passwordConf.text != password.text) {
        passwordConfError.value = true;
        errorText.add("Ulangi password harus sama dengan password");
      }
    }
  }
}
