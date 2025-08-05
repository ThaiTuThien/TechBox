import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/bottom_navigation.dart';
import 'package:techbox/src/features/account/presentation/widgets/account_list/account.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart.dart';
import 'package:techbox/src/features/product/presentation/screens/home_screen.dart';
import 'package:techbox/src/features/product/presentation/screens/product_list_screen.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/favorite_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String name;
  const MainNavigationScreen({super.key, required this.name});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pages = [
    HomeScreen(name: widget.name),
    ProductListScreen(),
    FavoriteScreen(),
    CartPage(),
    AccountPage(),
  ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: BottomNavigation(
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
        ),
      ),
    );
  }
}
