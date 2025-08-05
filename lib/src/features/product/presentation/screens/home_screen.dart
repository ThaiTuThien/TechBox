import 'package:flutter/material.dart';
import 'package:techbox/src/features/product/presentation/widgets/category_section.dart';
import 'package:techbox/src/features/product/presentation/widgets/custom_carousel.dart';
import 'package:techbox/src/features/product/presentation/widgets/greeting_header.dart';
import 'package:techbox/src/features/product/presentation/widgets/recommended_section.dart';
import 'package:techbox/src/features/product/presentation/widgets/search_bar_section.dart';

class HomeScreen extends StatefulWidget {
  final String? name;
  const HomeScreen({super.key, this.name});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingHeader(username: widget.name!),
                SearchBarSection(),
                CustomCarousel(),
                CategorySection(),
                RecommendedSection(),
                // PopularSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
