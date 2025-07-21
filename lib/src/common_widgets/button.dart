import 'package:flutter/material.dart';
import 'package:techbox/src/routing/main_navigation.dart';

class ButtonComponent extends StatefulWidget {
  final String text;
  const ButtonComponent({super.key, required this.text});

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  bool isLoading = false;

  void handlePress() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : handlePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF3C595D),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Đang tải...',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ] else ...[
            Text(
              widget.text,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
