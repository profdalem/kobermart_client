import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ppob_controller.dart';

class PpobView extends GetView<PpobController> {
  const PpobView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bayar Tagihan'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Akses Internet terputus',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
