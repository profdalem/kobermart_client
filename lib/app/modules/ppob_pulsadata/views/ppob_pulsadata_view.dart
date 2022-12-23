import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../style.dart';
import '../controllers/ppob_pulsadata_controller.dart';

class PpobPulsadataView extends GetView<PpobPulsadataController> {
  const PpobPulsadataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String product = Get.arguments["product"];
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Pulsa & Paket Data",
            style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          leading: TextButton(
            onPressed: () {},
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey.shade800,
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.phone_android)),
              title: Text("Operator"),
            ),
          ),
          Container(
            width: Get.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Nomor anda",
                  style: TextStyle(fontSize: 12),
                ),
                TextField(
                  controller: controller.phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      suffixIcon: Container(child: GestureDetector(onTap: controller.getContact, child: Icon(Icons.contacts, color: Colors.blue.shade700))),
                      focusColor: Colors.blueGrey.shade50,
                      fillColor: Colors.blueGrey.shade50,
                      filled: true,
                      hintText: "Contoh 0819xxx",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(5))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(5))),
                      // isDense: true,
                      contentPadding: EdgeInsets.all(12)),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    controller.contactNumber.value = value;
                  },
                  onTap: () {},
                ),
              ]),
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Obx(()=> Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: GestureDetector(
                    onTap: ()=> controller.isPulsa.value = true,
                    child: Container(
                      alignment: Alignment.center,
                      color: controller.isPulsa.value? Colors.blue.shade50: Colors.grey.shade50,
                      padding: EdgeInsets.all(10),
                      child: Text("Pulsa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: controller.isPulsa.value? Colors.blue: Colors.grey),)),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: ()=> controller.isPulsa.value = false,
                    child: Container(
                      alignment: Alignment.center,
                      color: !controller.isPulsa.value? Colors.blue.shade50: Colors.grey.shade50,
                      padding: EdgeInsets.all(10),
                      child: Text("Paket Data", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: !controller.isPulsa.value? Colors.blue: Colors.grey),)),
                  ),
                ),
              ])),
            ),
          ),
          sb10,
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.7, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemCount: 20,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          NumberFormat("#,##0", "id_ID").format(((index + 1) * 5000)),
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                        Text(
                          "Harga",
                          style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                        ),
                        Text(
                          "Rp11.500",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.limited;
    } else {
      return permission;
    }
  }
}
