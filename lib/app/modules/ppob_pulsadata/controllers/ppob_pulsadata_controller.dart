import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PpobPulsadataController extends GetxController {
  late TextEditingController phoneNumber;
  late dynamic getContact;

  var contactNumber = "".obs;
  var isPulsa = true.obs;

  @override
  void onInit() {
    phoneNumber = TextEditingController();
    getContact = () async {
      await Permission.contacts.request().then((value) async {
        if (value == PermissionStatus.granted) {
          print("contact");
          try {
            await ContactsService.openDeviceContactPicker(androidLocalizedLabels: true).then((value) {
              String result = "";
              if (value != null) {
                if (value.phones != null) {
                  var contacts = value.phones!;
                  Get.defaultDialog(
                      title: "Pilih Nomor",
                      content: Column(
                        children: List.generate(
                            contacts.length,
                            (index) => TextButton(
                                onPressed: () {
                                  result = contacts[index].value!;
                                  List temp = [];
                                  if (result.isNotEmpty) {
                                    for (var i = 0; i < result.length; i++) {
                                      if (result[i].isNum) {
                                        temp.add(result[i]);
                                      }
                                    }
                                    if (temp[0] == "8") {
                                      temp.insert(0, "0");
                                    }
                                    if (temp[0] == "6" && temp[1] == "2") {
                                      temp.removeAt(0);
                                      temp.removeAt(0);
                                      temp.insert(0, "0");
                                    }
                                  }
                                  phoneNumber.text = temp.join();
                                  contactNumber.value = temp.join();
                                  Get.back();
                                },
                                child: Text(contacts[index].value!))),
                      ));
                } else {
                  Get.snackbar("Gagal", "Kontak tidak memiliki nomor telepon");
                }
              }
            }).catchError((error) {
              print(error);
            });
          } catch (e) {
            print(e);
          }
        } else {
          Get.snackbar("Ijin Ditolak", "Tidak dapat mengakses kontak karena tidak diijinkan");
        }
      });
    };
    contactNumber.listen((event) {
      print("contact number berubah " + contactNumber.value);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    super.onClose();
  }
}
