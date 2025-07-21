import 'package:flutter/material.dart';
import 'package:techbox/src/features/product/presentation/widgets/category_section.dart';
import 'package:techbox/src/features/product/presentation/widgets/custom_carousel.dart';
import 'package:techbox/src/features/product/presentation/widgets/greeting_header.dart';
import 'package:techbox/src/features/product/presentation/widgets/search_bar_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingHeader(username: 'Nhan Luong'),
                SearchBarSection(),
                CustomCarousel(),
                CategorySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
