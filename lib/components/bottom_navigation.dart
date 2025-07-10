import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  static const List<String> _assetPaths = [
    'assets/image/home.png',
    'assets/image/shopping_bag.png',
    'assets/image/heart.png',
    'assets/image/cart.png',
    'assets/image/user.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 27),
      child: Container(
        width: 348,
        height: 62,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 20, 21),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_assetPaths.length, (index) {
            final isSelected = selectedIndex == index;
            return Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 22,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () => onTabChange(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(71),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        _assetPaths[index],
                        width: 24,
                        height: 24,
                        color: isSelected 
                            ? const Color.fromARGB(255, 60, 90, 93) 
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}