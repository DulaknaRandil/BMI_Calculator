import 'package:get/get.dart';
import 'package:bmi_781/Views/info_screen.dart';

class Calculate_Screen_Controller extends GetxController {
  void navigateToInfoScreen(double bmiResult) {
    if (bmiResult != null) {
      Get.to(() => InfoScreen(bmiResult: bmiResult));
    }
  }
}
