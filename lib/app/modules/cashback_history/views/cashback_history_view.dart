import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

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
      body: Center(
        child: Text(
          'CashbackHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
