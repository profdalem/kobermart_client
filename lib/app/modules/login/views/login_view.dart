import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/controllers/auth_controller.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

import 'package:kobermart_client/style.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
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
                    SvgPicture.asset("assets/logo/kobermart-logo-long.svg", width: Get.width * 0.5),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login",
                      style: header1,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email anggota",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DefaultTextInput(
                            controller: controller.emailC,
                            inputLabel: "Email anggota",
                            obsecure: false,
                          )
                        ],
                      ),
                    ),
                    sb10,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DefaultTextInput(
                            controller: controller.passwordC,
                            inputLabel: "Password",
                            obsecure: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () async {
                          if (authC.loading.value == false) {
                            authC.loading.value = true;
                            if (controller.emailC.text.isNotEmpty && controller.passwordC.text.isNotEmpty) {
                              GetUtils.isEmail(controller.emailC.text)
                                  ? await authC.login(controller.emailC.text, controller.passwordC.text).then((value) => authC.loading.value = false)
                                  : Get.defaultDialog(title: "Error", content: Text("Email tidak valid"));
                              authC.loading.value = false;
                            } else {
                              authC.loading.value = false;
                              Get.defaultDialog(title: "Error", content: Text("Email dan password harus diisi"));
                            }
                          }
                        },
                        child: Obx(() => Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Masuk",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  authC.loading.value
                                      ? SizedBox(
                                          width: 20,
                                        )
                                      : SizedBox(),
                                  authC.loading.value
                                      ? Container(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            )),
                        style: TextButton.styleFrom(padding: EdgeInsets.all(15), backgroundColor: Colors.blue),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Lupa password",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.TOKENINPUT, preventDuplicates: true);
                      },
                      child: Text(
                        "Registrasi dengan Token",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
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
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: inputLabel, border: InputBorder.none),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
