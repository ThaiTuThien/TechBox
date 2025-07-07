import 'package:flutter/material.dart';
import 'package:techbox/core/constants.dart';

class SuccessNotification extends StatelessWidget {
  final String subtitleText;
  final String buttonText;
  final Widget? navigateToPage;
  final VoidCallback? onButtonPressed;

  const SuccessNotification({
    Key? key,
    required this.subtitleText,
    required this.buttonText,
    this.navigateToPage,
    this.onButtonPressed,
  }) : super(key: key);

  // Hàm để hiển thị dialog
  static void show(
    BuildContext context, {
    required String subtitleText,
    required String buttonText,
    Widget? navigateToPage,
    VoidCallback? onButtonPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng dialog khi nhấn ra ngoài
      barrierColor: const Color.fromARGB(51, 25, 25, 25), 
      builder: (BuildContext context) {
        return SuccessNotification(
          subtitleText: subtitleText,
          buttonText: buttonText,
          navigateToPage: navigateToPage,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),

            // Green checkmark icon - exact match
            Container(
              width: 63.38,
              height: 63.38,
              decoration: BoxDecoration(
                color: const Color.fromARGB(51, 12, 148, 9),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 12, 148, 9),
                  width: 4,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: const Color.fromARGB(255, 12, 148, 9),
                size: 45,
              ),
            ),

            const SizedBox(height: 20),

            // Title "Chúc mừng !" - exact styling
            const Text(
              'Chúc mừng !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Customizable subtitle text - exact styling
            Text(
              subtitleText,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 128, 128, 128),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Button - exact styling and color
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Thực hiện hành động onButtonPressed nếu có
                  if (onButtonPressed != null) {
                    onButtonPressed!();
                  }
                  // Đóng dialog
                  Navigator.of(context).pop();
                  // Điều hướng đến trang mới nếu có
                  if (navigateToPage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => navigateToPage!),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantsColor.colorMain,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}