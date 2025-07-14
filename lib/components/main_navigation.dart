import 'package:flutter/material.dart';
import 'package:techbox/components/bottom_navigation.dart';
import 'package:techbox/screens/account.dart';
import 'package:techbox/screens/address/address_empty.dart';
import 'package:techbox/screens/cart/cart_empty.dart';
import 'package:techbox/screens/favorite_screen.dart';
import 'package:techbox/screens/home_screen.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    HomeScreen(),
    CartEmpty(),
    FavoriteScreen(),
    AddressEmpty(),
    AccountPage()
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
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}