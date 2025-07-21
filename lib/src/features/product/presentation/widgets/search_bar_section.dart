import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';

class SearchBarSection extends StatefulWidget {
  const SearchBarSection({super.key});

  @override
  State<SearchBarSection> createState() => _SearchBarSectionState();
}

class _SearchBarSectionState extends State<SearchBarSection> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm iPhone, MacBook, Airpods...',
          hintStyle: TextStyle(color: AppColors.darkGray, fontSize: 16.0),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: AppColors.darkGray,
            iconSize: 24,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.lightGray, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.darkGray, width: 2.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 8.5),
        ),
      ),
    );
  }
}
