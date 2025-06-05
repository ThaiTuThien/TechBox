import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:techbox/widgets/onboard-screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      backgroundColor: Colors.white,
      useImmersiveMode: true,
      gifPath: 'assets/image/splash_screen.gif', 
      gifHeight: double.maxFinite,
      gifWidth: double.maxFinite,
      nextScreen: OnBoardScreen(),
      duration: Duration(milliseconds: 4600),
    );
  }
}
