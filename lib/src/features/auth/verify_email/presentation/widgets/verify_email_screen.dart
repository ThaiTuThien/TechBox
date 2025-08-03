import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:techbox/src/common_widgets/button.dart';
import 'package:techbox/src/common_widgets/notifcation.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/verify_email/domain/dtos/verify_email_dto.dart';
import 'package:techbox/src/features/auth/verify_email/presentation/controllers/verify_email_controller.dart';
import 'package:techbox/src/features/auth/verify_email/presentation/states/verify_email_state.dart';
import 'package:techbox/src/features/product/presentation/screens/home_screen.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreen();
}

class _VerifyEmailScreen extends ConsumerState<VerifyEmailScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  Future<void> _onCompleted() async {
    final dto = VerifyEmailDto(
      email: widget.email, 
      otp: _pinController.text.trim()
    );
    await ref.read(verifyEmailControllerProvider.notifier).verifyEmail(dto);
    if (!mounted) return;

    final state = ref.read(verifyEmailControllerProvider);
    if (state is VerifyEmailSuccess) {
      NotificationComponent(title: 'Thành công', description: 'Đăng kí thành công', type: 'success').build(context);
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    else if (state is VerifyEmailError) {
      print (dto);
      print(state.message);
      NotificationComponent(title: 'Thất bại', description: state.message, type: 'error').build(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(fontSize: 20, color: Colors.black),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.blue),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey.shade200,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nhập mã 6 số', style: ConstantText.titleText),
            const SizedBox(height: 20),
            const Text(
              'Nhập mã xác minh gồm 6 chữ số đã gửi đến email của bạn',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Pinput(
              length: 6,
              controller: _pinController,
              focusNode: _focusNode,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ButtonComponent(
              text: 'Xác minh',
              isLoading: false,
              onPressed: () => _onCompleted(),
            ),
          ],
        ),
      ),
    );
  }
}
