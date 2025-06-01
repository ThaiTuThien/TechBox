import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final bool isSuccess;
  final TextInputType keyboardType;

  const InputComponent({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.errorText,
    this.isSuccess = false,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = errorText != null 
      ? Colors.red
      : isSuccess 
        ? Colors.green
        : Colors.grey.shade300;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(8)
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(8)
                )
              ),
            ),
            if (errorText != null) 
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.error_outline, color: Colors.red),
              )
            else if (isSuccess) 
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.check_circle_outline_outlined, color: Colors.green),
              )
          ],
        ),
        if (errorText != null) 
          Padding(
            padding: EdgeInsets.only(top: 6, left: 4),
            child: Text(errorText!, style: TextStyle(color: Colors.red, fontSize: 12)),
          )
      ],
    );
  }
}
