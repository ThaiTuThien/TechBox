import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:techbox/src/features/auth/presentation/signin_google/button-google.dart';
import 'package:techbox/src/common_widgets/button.dart';
import 'package:techbox/src/common_widgets/input.dart';
import 'package:techbox/src/features/auth/presentation/divided_section/or.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/login/presentation/login.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tạo tài khoản', style: ConstantText.titleText),
                SizedBox(height: 8),
                Text(
                  'Hãy tạo tài khoản của bạn.',
                  style: ConstantText.descriptionText,
                ),
                SizedBox(height: 16),
                InputComponent(label: 'Họ tên', hint: 'Nhập họ tên của bạn'),
                SizedBox(height: 16),
                InputComponent(label: 'Email', hint: 'Nhập email của bạn'),
                SizedBox(height: 16),
                InputComponent(
                  label: 'Mật khẩu',
                  hint: 'Nhập mật khẩu của bạn',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ButtonComponent(text: 'Tạo tài khoản'),
                OrComponent(),
                ButtonGoogleComponent(),
                SizedBox(height: 220),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bạn đã tài khoản?', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
