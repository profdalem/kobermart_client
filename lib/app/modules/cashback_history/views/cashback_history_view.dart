import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobermart_client/app/helpers/general_helper.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/cashback_history_controller.dart';

class CashbackHistoryView extends GetView<CashbackHistoryController> {
  const CashbackHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Cashback'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Get.toNamed(
              Routes.HOME,
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.initData(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: PanelTitle(title: "Rentang waktu"),
            ),
            Obx(() => GestureDetector(
                  onTap: () {
                    showDateRangePicker(context: context, firstDate: DateTime(2021), lastDate: DateTime.now()).then((value) async {
                    controller.isLoading.value = true;
                      if (value != null) {
                        controller.startDate.value = value.start;
                        controller.endDate.value = value.end;
                        await getCashbackHistory(authC.refId.value, value.start, value.end).then((value) {
                          controller.cashback.value = value;
                        });
                      }
                    controller.isLoading.value = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              DateFormat.yMMMEd("id_ID").format(controller.startDate.value),
                              style: TextStyle(fontSize: 14),
                            )),
                        Text(" - "),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              DateFormat.yMMMEd("id_ID").format(controller.endDate.value),
                              style: TextStyle(fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                )),
            sb10,
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: PanelTitle(title: "Riwayat Cashback"),
            ),
            sb10,
            Obx(() => controller.isLoading.value
                ? Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : (controller.cashback.isEmpty
                    ? Center(child: Text("Kosong"))
                    : Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                          children: List.generate(
                              controller.cashback.length,
                              (index) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Text(controller.cashback[index]["date"] == DateTime.now().toLocal().toString().substring(0, 10)
                                            ? "Hari ini"
                                            : controller.cashback[index]["date"]),
                                      ),
                                      Card(
                                        child: Container(
                                          width: Get.width,
                                          padding: EdgeInsets.only(top: 0, bottom: 0),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  child: SvgPicture.asset(
                                                    "assets/icons/icon-cashback.svg",
                                                    color: Colors.blue,
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerLeft,
                                                  ),
                                                  backgroundColor: Colors.transparent,
                                                ),
                                                title: Text(
                                                  "Rp" + NumberFormat("#,##0", "id_ID").format(controller.cashback[index]["sum"]),
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                subtitle: Text("Total cashback"),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                  color: Colors.amber.shade100,
                                                  width: double.infinity,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Text(
                                                            "Ref: ",
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                          ),
                                                          Text(
                                                            "Rp" + NumberFormat("#,##0", "id_ID").format(controller.cashback[index]["ref"]),
                                                            style: TextStyle(fontSize: 11),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Text(
                                                            "Plan A: ",
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                          ),
                                                          Text(
                                                            "Rp" + NumberFormat("#,##0", "id_ID").format(controller.cashback[index]["cba"]),
                                                            style: TextStyle(fontSize: 11),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Row(
                                                        children: [
                                                          Text(
                                                            "Plan B: ",
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                          ),
                                                          Text(
                                                            "Rp" + NumberFormat("#,##0", "id_ID").format(controller.cashback[index]["cbb"]),
                                                            style: TextStyle(fontSize: 11),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      sb15
                                    ],
                                  )),
                        )),
                      )))
          ],
        ),
      ),
    );
  }
}
