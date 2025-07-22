import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/bottom_navigation.dart';
import 'package:techbox/src/features/account/presentation/widgets/account_list/account.dart';
import 'package:techbox/src/features/address/presentation/update_address/update_address.dart';
import 'package:techbox/src/features/cart/presentation/empty_cart/cart_empty.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/favorite_screen.dart';
import 'package:techbox/src/features/product/presentation/home_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    HomeScreen(),
    CheckoutPage(),
    FavoriteScreen(),
    CartPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
