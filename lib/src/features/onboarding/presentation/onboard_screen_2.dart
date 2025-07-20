import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardScreen2 extends StatelessWidget {
  const OnBoardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Center(
          child: Column(
            children: [
              Lottie.asset('assets/lotties/onboard_2.json', width: 300, height: 300),
              SizedBox(height: 56),
              Text(
                'Trải nghiệm tương lai với điện thoại 3D',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF3C595D),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Xoay và khám phá iPhone 16 Pro Max hoàn toàn mới với từng chi tiết tuyệt đẹp',
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
