import 'package:flutter/material.dart';
import 'package:techbox/components/button.dart';
import 'package:techbox/components/input.dart';
import 'package:techbox/core/constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Khôi phục mật khẩu', style: ConstantText.titleText),
                SizedBox(height: 8),
                Text('Nhập email của bạn để khôi phục mật khẩu.', style: ConstantText.descriptionText),
                SizedBox(height: 16),
                InputComponent(
                  label: 'Email',
                  hint: 'Nhập email của bạn',
                  controller: TextEditingController(),
                ),
                SizedBox(height: 24),
                ButtonComponent(
                  text: 'Gửi mã'
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}