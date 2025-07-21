import 'package:flutter/material.dart';
import 'package:techbox/src/features/auth/presentation/signin_google/button-google.dart';
import 'package:techbox/src/common_widgets/button.dart';
import 'package:techbox/src/common_widgets/input.dart';
import 'package:techbox/src/features/auth/presentation/divided_section/or.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/forgot_password/presentation/forgot_password.dart';
import 'package:techbox/src/features/auth/register/presentation/wiggets/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đăng nhập tài khoản',
                          style: ConstantText.titleText,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Thật tuyệt khi được gặp lại bạn.',
                          style: ConstantText.descriptionText,
                        ),
                        SizedBox(height: 16),
                        InputComponent(
                          label: 'Email',
                          hint: 'Nhập email của bạn',
                          controller: nameController,
                        ),
                        SizedBox(height: 16),
                        InputComponent(
                          label: 'Mật khẩu',
                          hint: 'Nhập mật khẩu của bạn',
                          controller: passwordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text('Quên mật khẩu?'),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ForgotPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                'Khôi phục mật khẩu',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        ButtonComponent(text: 'Đăng nhập'),
                        OrComponent(),
                        ButtonGoogleComponent(),
                        Spacer(),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bạn có tài khoản chưa?',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Đăng ký',
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
          },
        ),
      ),
    );
  }
}
