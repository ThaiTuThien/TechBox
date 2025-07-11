import 'package:flutter/material.dart';
import 'package:techbox/components/main_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đây là trang home'),
        backgroundColor: Colors.white,
      ),
    );
  }
}