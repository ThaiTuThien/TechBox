import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/input.dart';
import 'package:techbox/src/core/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back)
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0),
              _textHeader(),
              SizedBox(height: 8),
              _textSubHeader('Nhập email của bạn để tiến hành xác thực'),
              _textSubHeader('Chúng tôi sẽ gửi mã 6 số về email của bạn'),
              SizedBox(height: 23),
              _emailInput(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: SizedBox(
            width: 341,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantsColor.colorMain,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Gửi mã',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textHeader() {
    return Text(
      'Quên mật khẩu',
      style: TextStyle(
        fontSize: 32,
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        color: ConstantsColor.colorMain,
      ),
    );
  }

  Widget _textSubHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: const Color.fromARGB(255, 128, 128, 128),
      ),
    );
  }

  Widget _emailInput() {
    return InputComponent(
      label: 'Email',
      hint: 'Nhập email của bạn',
      controller: emailController,
    );
  }
}
