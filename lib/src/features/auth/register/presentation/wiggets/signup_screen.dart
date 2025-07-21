import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/auth/presentation/signin_google/button-google.dart';
import 'package:techbox/src/common_widgets/button.dart';
import 'package:techbox/src/common_widgets/input.dart';
import 'package:techbox/src/features/auth/presentation/divided_section/or.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/login/presentation/login.dart';
import 'package:techbox/src/features/auth/register/data/dtos/register_dto.dart';
import 'package:techbox/src/features/auth/register/presentation/controllers/register_controller.dart';
import 'package:techbox/src/features/auth/register/presentation/states/register_state.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _onRegister() async {
    final dto = RegisterDto(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.toString(),
    );
    await ref.read(registerControllerProvider.notifier).register(dto);

    if (!mounted) return;

    final state = ref.read(registerControllerProvider);
    if (state is RegisterSuccess) {
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.minimal,
        title: Text("Thành công"),
        description: RichText(text: TextSpan(text: state.message)),
        alignment: Alignment.topRight,
        animationDuration: Duration(milliseconds: 3000),
        showProgressBar: true,
      );

      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    } else if (state is RegisterError) {
      debugPrint("Đăng ký lỗi: ${state.message}");
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        title: Text("Thất bại"),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        description: RichText(text: TextSpan(text: state.message)),
        borderRadius: BorderRadius.circular(8),
        alignment: Alignment.topRight,
        animationDuration: Duration(milliseconds: 300),
        showProgressBar: true,
        autoCloseDuration: Duration(milliseconds: 1500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);

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
                      vertical: 20,
                      horizontal: 20,
                    ),
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
                        InputComponent(
                          label: 'Họ tên',
                          hint: 'Nhập họ tên của bạn',
                          controller: _nameController,
                        ),
                        SizedBox(height: 16),
                        InputComponent(
                          label: 'Email',
                          hint: 'Nhập email của bạn',
                          controller: _emailController,
                        ),
                        SizedBox(height: 16),
                        InputComponent(
                          label: 'Mật khẩu',
                          hint: 'Nhập mật khẩu của bạn',
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ButtonComponent(
                          text:
                              state is RegisterLoading
                                  ? 'Đang tạo...'
                                  : 'Tạo tài khoản',
                          onPressed:
                              state is RegisterLoading ? null : _onRegister,
                          isLoading: state is RegisterLoading,
                        ),
                        OrComponent(),
                        ButtonGoogleComponent(),
                        Spacer(),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bạn đã tài khoản?',
                                style: TextStyle(fontSize: 16),
                              ),
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
          },
        ),
      ),
    );
  }
}
