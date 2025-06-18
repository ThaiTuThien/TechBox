import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:techbox/widgets/onboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      childWidget: SizedBox(
        height: 300,
        width: 300,
        child: Image.asset('assets/image/splash_screen.png'),
      ),
      nextScreen: OnBoardScreen(),
    );
  }
}
