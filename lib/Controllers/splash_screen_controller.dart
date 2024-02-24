import 'dart:async';

import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 5), () {
      isLoading.value = false;
      Get.offNamed('/calculate'); // navigate to CalculateScreen
    });
  }
}
