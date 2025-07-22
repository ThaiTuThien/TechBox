import 'package:flutter/material.dart';
import 'package:techbox/src/routing/main_navigation.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final Future<void> Function()? onPressed;
  final bool isLoading;

  const ButtonComponent({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3C595D),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Đang tải...',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ] else ...[
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
