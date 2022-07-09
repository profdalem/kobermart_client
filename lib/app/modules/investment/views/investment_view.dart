import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/investment_controller.dart';

class InvestmentView extends GetView<InvestmentController> {
  const InvestmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanam Modal'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/modal.png"),
            Text(
              'Coming soon',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
