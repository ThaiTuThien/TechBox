import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardScreen1 extends StatelessWidget {
  const OnBoardScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Center(
          child: Column(
            children: [
              Lottie.asset('assets/lotties/onboard_1.json', height: 300, width: 300),
              SizedBox(height: 56),
              Text(
                'Khám phá thế giới Apple cùng TechBox',
                style: TextStyle(
                  color: Color(0xFF3C595D),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Trải nghiệm mua sắm với các thiết bị Apple cấp cao - tất cả trong một nơi duy nhất ',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
