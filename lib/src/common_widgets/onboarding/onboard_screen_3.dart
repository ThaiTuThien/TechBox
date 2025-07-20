import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardScreen3 extends StatelessWidget {
  const OnBoardScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Center(
          child: Column(
            children: [
              Lottie.asset('assets/lotties/onboard_3.json', height: 300, width: 300),
              SizedBox(height: 56),
              Text(
                'Chọn đúng, mua nhanh – không lo suy nghĩ nhiều',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF3C595D),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Thanh toán nhanh chóng, ưu đãi chọn lọc và gợi ý thông minh – tất cả ngay trong tầm tay bạn.',
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
