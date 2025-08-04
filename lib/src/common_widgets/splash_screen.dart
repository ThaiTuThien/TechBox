import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/common_widgets/onboard_screen.dart';
import 'package:techbox/src/routing/main_navigation.dart';
import 'package:techbox/src/utils/token_valid.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    final name = pref.getString('name');

    await Future.delayed(Duration(seconds: 2));

    if (!mounted) return;
    if (token != null && isTokenValid(token)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavigationScreen(name: name!)));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      childWidget: SizedBox(
        height: 300,
        width: 300,
        child: Image.asset('assets/image/splash_screen.png'),
      )
    );
  }
}
