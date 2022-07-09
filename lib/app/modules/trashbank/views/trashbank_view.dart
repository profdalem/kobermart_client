import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/trashbank_controller.dart';

class TrashbankView extends GetView<TrashbankController> {
  const TrashbankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bank Sampah'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/sampah.png"),
              Text(
                'Coming soon',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
