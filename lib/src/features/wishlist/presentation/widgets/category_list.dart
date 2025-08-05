import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryList({
    super.key,
    required this.title, 
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:
                isSelected
                    ? BorderSide.none
                    : BorderSide(color: Colors.grey.shade300),
          ),
          backgroundColor: isSelected ? Color(0xFF2C4E4A) : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        child: Text(title, style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}
