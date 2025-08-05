import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  static const List<dynamic> _unselectedIcons = [
    'assets/image/home.svg',
    Icons.shopping_bag_outlined,
    Icons.favorite_outline,
    Icons.shopping_cart_outlined,
    Icons.account_circle_outlined,
  ];

  static const List<dynamic> _selectedIcons = [
    'assets/image/home.svg',
    Icons.shopping_bag,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.account_circle,
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
        children: List.generate(_unselectedIcons.length, (index) {
          final bool isSelected = selectedIndex == index;
          final item =
              isSelected ? _selectedIcons[index] : _unselectedIcons[index];

          final Color iconColor =
              isSelected ? const Color.fromARGB(255, 60, 90, 93) : Colors.white;

          Widget iconWidget;
          if (item is String && item.endsWith('.svg')) {
            iconWidget = SvgPicture.asset(
              item,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            );
          } else if (item is IconData) {
            iconWidget = Icon(item, size: 24, color: iconColor);
          } else {
            iconWidget = const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: () => onTabChange(index),
            behavior: HitTestBehavior.translucent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(child: iconWidget),
            ),
          );
        }),
      ),
    );
  }
}
