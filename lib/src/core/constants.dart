import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConstantText {
  static TextStyle titleText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1,
    color: ConstantsColor.colorMain
  );
  static TextStyle descriptionText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: Color.fromRGBO(0, 0, 0, 0.6)
  );
}

class ConstantsColor {
  static Color colorMain = Color(0xFF3C595D);
}