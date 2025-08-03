import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/notifcation.dart';
import 'package:techbox/src/features/auth/login/data/dtos/login_dto.dart';
import 'package:techbox/src/features/auth/login/presentation/controllers/login_controllers.dart';
import 'package:techbox/src/features/auth/login/presentation/states/login_states.dart';
import 'package:techbox/src/features/auth/presentation/signin_google/button-google.dart';
import 'package:techbox/src/common_widgets/button.dart';
import 'package:techbox/src/common_widgets/input.dart';
import 'package:techbox/src/features/auth/presentation/divided_section/or.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/forgot_password/presentation/forgot_password.dart';
import 'package:techbox/src/features/auth/register/presentation/wiggets/signup_screen.dart';
import 'package:techbox/src/features/product/presentation/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final dto = LoginDto(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(), 
      role: 'user'
    );

    await ref.read(loginControllerProvider.notifier).login(dto);
    if (!mounted) return;

    final state = ref.read(loginControllerProvider);
    if (state is LoginSuccess) {
      NotificationComponent(title: 'Thành công', description: 'Đăng nhập thành công', type: 'success').build(context);
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    else if (state is LoginError) {
      NotificationComponent(title: 'Thất bại', description: state.message, type: 'error').build(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
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
                          controller: emailController,
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
                        ButtonComponent(text: 'Đăng nhập', isLoading: state is LoginLoading, onPressed: () => _login(), ),
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
