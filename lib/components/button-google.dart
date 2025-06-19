import 'package:flutter/material.dart';

class ButtonGoogleComponent extends StatelessWidget {
  const ButtonGoogleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {}, 
      label: Text('Đăng nhập với Google', style: TextStyle(color: Colors.black),), 
      icon: Image.asset('assets/image/google.png', height: 20),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
}