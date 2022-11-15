import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

import '../controllers/ppob_controller.dart';

class PpobView extends GetView<PpobController> {
  const PpobView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPOB'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabC,
          tabs: controller.myTabs,
        ),
      ),
      body: TabBarView(controller: controller.tabC, children: [
        Center(child: Text(controller.tabC.index.toString())),
        Center(child: Text(controller.tabC.index.toString())),
        Center(child: Text(controller.tabC.index.toString())),
      ]),
    );
  }
}
