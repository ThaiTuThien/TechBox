import 'package:flutter/material.dart';

Color colorFromHex(String hexColor) {
 
  if (hexColor.isEmpty || hexColor.length < 6) {
    return Colors.grey;
  }

  final hexCode = hexColor.toUpperCase().replaceAll('#', '');
  
  String finalHexCode = hexCode;
  if (finalHexCode.length == 6) {
    finalHexCode = 'FF$finalHexCode';
  }
  
  try {
    return Color(int.parse(finalHexCode, radix: 16));
  } catch (e) {
    print('Lỗi chuyển đổi mã màu hex: $hexColor, Lỗi: $e');
    return Colors.grey;
  }
}