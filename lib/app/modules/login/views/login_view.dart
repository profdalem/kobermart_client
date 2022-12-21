import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:kobermart_client/app/routes/app_pages.dart';
import 'package:kobermart_client/config.dart';
import 'package:kobermart_client/firebase.dart';
import 'package:kobermart_client/style.dart';

import '../../../controllers/auth_controller.dart';

class LoginView extends GetView {
  LoginView({Key? key}) : super(key: key);

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    if (boxStorage.read("email") != null && boxStorage.read("password") != null) {
      authC.emailC.text = boxStorage.read("email");
      authC.passwordC.text = boxStorage.read("password");
    }
    ;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                            controller: authC.emailC,
                            inputLabel: "Email anggota",
                            obsecure: false,
                            password: false,
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
                          Obx(() => DefaultTextInput(
                                controller: authC.passwordC,
                                inputLabel: "Password",
                                obsecure: authC.isObsecure.value,
                                password: true,
                              )),
                        ],
                      ),
                    ),
                    sb10,
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: authC.rememberMe.value,
                              onChanged: (value) {
                                authC.rememberMe.value = !authC.rememberMe.value;
                                print(authC.rememberMe.value);
                              },
                              checkColor: Colors.blue,
                              fillColor: MaterialStatePropertyAll(Colors.white),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Ingat email & password",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                    sb20,
                    Obx(() => authC.loading.value
                        ? Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              onPressed: () async {
                                if (authC.loading.value == false) {
                                  authC.loading.value = true;
                                  if (authC.emailC.text.isNotEmpty && authC.passwordC.text.isNotEmpty) {
                                    GetUtils.isEmail(authC.emailC.text)
                                        ? await authC
                                            .login(authC.emailC.text, authC.passwordC.text)
                                            .then((value) => authC.loading.value = false)
                                        : Get.defaultDialog(title: "Error", content: Text("Email tidak valid"));
                                    authC.loading.value = false;
                                  } else {
                                    authC.loading.value = false;
                                    Get.defaultDialog(title: "Error", content: Text("Email dan password harus diisi"));
                                  }
                                }
                              },
                              child: Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Masuk",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              style: TextButton.styleFrom(padding: EdgeInsets.all(15), backgroundColor: Colors.blue),
                            ),
                          )),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.TOKENINPUT);
                      },
                      child: Text(
                        "Lupa password",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.TOKENINPUT, preventDuplicates: true);
                    //   },
                    //   child: Text(
                    //     "Registrasi dengan Token",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                    if (devMode)
                      IconButton(
                          onPressed: () {
                            authC.emailC.text = "kobermart@gmail.com";
                            authC.passwordC.text = "123456";
                          },
                          icon: Icon(Icons.refresh))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class DefaultTextInput extends StatelessWidget {
  DefaultTextInput({
    Key? key,
    required this.controller,
    required this.inputLabel,
    required this.obsecure,
    required this.password,
  }) : super(key: key);

  final TextEditingController controller;
  final String inputLabel;
  final bool obsecure;
  final bool password;
  final authC = Get.find<AuthController>();

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
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: inputLabel,
              border: InputBorder.none,
              suffixIcon: password
                  ? (obsecure
                      ? GestureDetector(
                          onTap: () {
                            authC.isObsecure.value = false;
                          },
                          child: Icon(Icons.remove_red_eye))
                      : GestureDetector(
                          onTap: () {
                            authC.isObsecure.value = true;
                          },
                          child: Icon(Icons.remove_red_eye_outlined)))
                  : Icon(Icons.email)),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
