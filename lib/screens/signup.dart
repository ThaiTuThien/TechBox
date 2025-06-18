import 'package:flutter/material.dart';
import 'package:techbox/components/button-google.dart';
import 'package:techbox/components/button.dart';
import 'package:techbox/components/input.dart';
import 'package:techbox/core/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create an account', style: ConstantText.titleText),
              SizedBox(height: 8),
              Text(
                "Let's create your account.",
                style: ConstantText.descriptionText,
              ),
              SizedBox(height: 24),
              InputComponent(label: 'Full Name', hintText: 'Enter your full name', ),
              SizedBox(height: 16),
              InputComponent(label: 'Email', hintText: 'Enter your email address'),
              SizedBox(height: 16),
              InputComponent(label: 'Password', hintText: 'Enter your password'),
              SizedBox(height: 24),
              ButtonComponent(text: 'Create an Account', onPressed: () {

              },),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Or', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF808080)))),
                  Expanded(child: Divider())
                ],
              ),
              SizedBox(height: 24),
              ButtonGoogleComponent(),
              SizedBox(height: 220),
              Center(
                child: RichText(text: TextSpan(
                  style: ConstantText.descriptionText,
                  children: [
                    TextSpan(text: 'Already have an account? '),
                    TextSpan(text: 'Log In', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline, fontWeight: FontWeight.bold))
                  ]
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
