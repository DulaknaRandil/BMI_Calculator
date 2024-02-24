import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bmi_781/Views/info_screen.dart';

import '../Controllers/calculate_screen_controller.dart';

class Calculate_Screen extends StatefulWidget {
  @override
  _Calculate_ScreenState createState() => _Calculate_ScreenState();
}

class _Calculate_ScreenState extends State<Calculate_Screen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  Calculate_Screen_Controller calculate_screen_controller =
      Get.put(Calculate_Screen_Controller());
  double? bmiResult;

  void _calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        // Calculate BMI
        bmiResult = weight / ((height / 100) * (height / 100));
      });
    }
  }

  void _clearFields() {
    setState(() {
      heightController.clear();
      weightController.clear();
      bmiResult = null;
    });
  }

  Color _getCategoryColor(double bmi) {
    if (bmi < 16) {
      return Colors.red; // Severe undernourishment
    } else if (bmi >= 16 && bmi < 17) {
      return Colors.orange; // Medium undernourishment
    } else if (bmi >= 17 && bmi < 18.5) {
      return Color.fromARGB(255, 251, 227, 13); // Slight undernourishment
    } else if (bmi >= 18.5 && bmi < 25) {
      return Colors.green; // Normal nutrition state
    } else if (bmi >= 25 && bmi < 30) {
      return Colors.orange; // Overweight
    } else if (bmi >= 30 && bmi < 40) {
      return Colors.red; // Obesity
    } else {
      return Colors.purple; // Pathological obesity
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            'Calculate BMI',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/cal.gif',
                width: 400,
                height: 300,
                fit: BoxFit.cover,
              ),
              if (bmiResult != null)
                Text(
                  'Your BMI: ${bmiResult!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 24,
                    color: _getCategoryColor(
                        bmiResult!), // Change color based on category
                  ),
                ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(
                      color: Colors.green), // Set label text color to green
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .green), // Set border color to green when focused
                  ),
                ),
                cursorColor: Colors.green, // Set cursor color to green
              ),
              SizedBox(height: 20),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  labelStyle: TextStyle(
                      color: Colors.green), // Set label text color to green
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .green), // Set border color to green when focused
                  ),
                ),
                cursorColor: Colors.green, // Set cursor color to green
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _calculateBMI();
                },
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: bmiResult != null
                    ? () {
                        calculate_screen_controller
                            .navigateToInfoScreen(bmiResult!);
                      }
                    : null,
                child: Text(
                  'Info',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 10),
              IconButton(
                onPressed: _clearFields,
                icon: Tooltip(
                  message: 'Reset',
                  child: Icon(
                    Icons.restart_alt,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
