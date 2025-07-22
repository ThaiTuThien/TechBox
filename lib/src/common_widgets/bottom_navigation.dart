import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  static const List<IconData> _assetPaths = [
    Icons.home,
    Icons.shopping_bag_outlined,
    Icons.favorite_outline,
    Icons.shopping_cart_outlined,
    Icons.account_circle_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 12, 20, 21),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withValues(alpha: 0.1)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_assetPaths.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTabChange(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _assetPaths[index],
                  size: 24,
                  color:
                      isSelected
                          ? const Color.fromARGB(255, 60, 90, 93)
                          : Colors.white,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
