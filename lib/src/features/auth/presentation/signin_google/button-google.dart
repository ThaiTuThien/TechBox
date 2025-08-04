import 'package:flutter/material.dart';
import 'package:techbox/src/routing/main_navigation.dart';

class ButtonGoogleComponent extends StatelessWidget {
  const ButtonGoogleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        
      },
      label: Text(
        'Đăng nhập với Google',
        style: TextStyle(color: Colors.black),
      ),
      icon: Image.asset('assets/image/google.png', height: 20),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Color(0xFFe6e6e6),
        elevation: 2,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
