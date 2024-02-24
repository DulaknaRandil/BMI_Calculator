import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/calculate_screen.dart';
import 'Views/info_screen.dart';
import 'Views/splash_screen.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/calculate', page: () => Calculate_Screen()),
        GetPage(
            name: '/info',
            page: () => InfoScreen(
                  bmiResult: 0,
                )),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Main());
}
