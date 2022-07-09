import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/style.dart';

import '../controllers/tokeninput_controller.dart';

class TokeninputView extends GetView<TokeninputController> {
  const TokeninputView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF31AAEF),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: Image.asset("assets/images/bg-elipse-1.png"),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Image.asset("assets/images/bg-elipse-2.png"),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/logo/kobermart-logo-long.svg",
                        width: Get.width * 0.5),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Input Token",
                      style: header1,
                    ),
                    sb10,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          DefaultTextInput(
                            controller: controller.tokenC,
                            inputLabel: "Input token anda disini",
                            obsecure: false,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: PanelTitle(
                            title: "Validasi",
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back(canPop: true);
                      },
                      child: Text(
                        "Kembali",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class DefaultTextInput extends StatelessWidget {
  const DefaultTextInput({
    Key? key,
    required this.controller,
    required this.inputLabel,
    required this.obsecure,
  }) : super(key: key);

  final TextEditingController controller;
  final String inputLabel;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        color: Colors.white,
        child: TextField(
          controller: controller,
          autocorrect: false,
          obscureText: obsecure,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration:
              InputDecoration(hintText: inputLabel, border: InputBorder.none),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
