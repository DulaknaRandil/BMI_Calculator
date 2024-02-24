import 'package:flutter/material.dart';
import 'dart:math';

class InfoScreen extends StatefulWidget {
  final double bmiResult; // BMI result passed from previous screen

  InfoScreen({Key? key, required this.bmiResult}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween<double>(begin: 10, end: widget.bmiResult)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getCategoryColor(double bmi) {
    if (bmi < 16) {
      return Colors.red; // Severe undernourishment
    } else if (bmi >= 16 && bmi < 17) {
      return Colors.orange; // Medium undernourishment
    } else if (bmi >= 17 && bmi < 18.5) {
      return Colors.yellow; // Slight undernourishment
    } else if (bmi >= 18.5 && bmi < 25) {
      return Colors.green; // Normal nutrition state
    } else if (bmi >= 25 && bmi < 30) {
      return Colors.orange; // Overweight
    } else if (bmi >= 30 && bmi < 40) {
      return Colors.red; // Obesity
    } else {
      return Colors.red; // Pathological obesity
    }
  }

  String _getCategory(double bmi) {
    if (bmi < 16) {
      return 'Severe undernourishment';
    } else if (bmi >= 16 && bmi < 17) {
      return 'Medium undernourishment';
    } else if (bmi >= 17 && bmi < 18.5) {
      return 'Slight undernourishment';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal nutrition state';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else if (bmi >= 30 && bmi < 40) {
      return 'Obesity';
    } else {
      return 'Pathological obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Text(
            'BMI Result',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 3), // Adjust the duration here
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/fitness.gif',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Your BMI Result:',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _animation.value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: _getCategoryColor(_animation.value),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Category:',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              _getCategory(_animation.value),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getCategoryColor(_animation.value),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SliderPainter(
                      value: _animation.value,
                      color: _getCategoryColor(_animation.value),
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderPainter extends CustomPainter {
  final double value;
  final Color color;

  SliderPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grayPaint = Paint()
      ..color = Color.fromARGB(255, 216, 215, 215)
          .withOpacity(0.5) // Adjust opacity as needed
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint mainPaint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY) - 10;

    final double startAngle = -pi / 2;
    final double sweepAngle = pi * (value - 10) / 30;

    // Draw gray outline
    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        2 * pi,
        false,
        grayPaint);

    // Draw main arc
    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        sweepAngle,
        false,
        mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
