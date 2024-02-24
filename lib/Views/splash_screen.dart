import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:bmi_781/Views/calculate_screen.dart';

import '../Controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 234),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Image(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.cover,
                width: 280,
                height: 280,
              ),
            ),
          ),
          SizedBox(height: 20),
          GetBuilder<SplashScreenController>(
            init: SplashScreenController(),
            builder: (controller) {
              return controller.isLoading.value ? _buildSpinner() : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpinner() {
    return SpinKitWaveSpinner(
      waveColor: Colors.green,
      trackColor: Color.fromARGB(255, 186, 206, 197),
      size: 100.0,
      color: Colors.green,
    );
  }
}
