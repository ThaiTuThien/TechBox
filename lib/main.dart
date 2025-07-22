import 'package:flutter/material.dart';
import 'package:techbox/src/features/account/presentation/widgets/account_list/account.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: AccountPage(),
    );
  }
}
