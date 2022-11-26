import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/controllers/auth_controller.dart';
import 'app/modules/widgets/splashscreen.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await GetStorage.init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print(fcmToken);
  }).onError((err) {
    print(err);
  });

  await initializeDateFormatting('id_ID', null)
      .then((value) => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp())));
}

class MyApp extends StatelessWidget {
  final authC = Get.put(
    AuthController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 500)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                defaultTransition: Transition.rightToLeft,
                title: "Kobermart Client App",
                theme: ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
                initialRoute: authC.isAuth.value ? AppPages.INITIAL : Routes.LOGIN,
                getPages: AppPages.routes,
              ));
        }
        return FutureBuilder(
          future: authC.firstInitialized(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );
  }
}
