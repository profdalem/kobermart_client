import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/controllers/auth_controller.dart';
import 'app/modules/widgets/splashscreen.dart';
import 'app/routes/app_pages.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  // final connC = Get.put(ConnectivityController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                defaultTransition: Transition.rightToLeft,
                title: "Kobermart Client App",
                theme: ThemeData.light().copyWith(
                    textTheme: GoogleFonts.poppinsTextTheme(
                        Theme.of(context).textTheme)),
                initialRoute:
                    authC.isAuth.value ? AppPages.INITIAL : Routes.LOGIN,
                getPages: AppPages.routes,
              ));
        }
        return FutureBuilder(
          future: authC.firstInitialized(),
          builder: (context, snapshot) => SplashScreen(),
        );

        // return GetMaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   title: "Kobermart Client App",
        //   initialRoute: AppPages.INITIAL,
        //   getPages: AppPages.routes,
        //   defaultTransition: Transition.rightToLeft,
        // );
      },
    );
  }
}
