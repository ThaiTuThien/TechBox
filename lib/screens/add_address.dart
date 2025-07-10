import 'package:flutter/material.dart';
import 'package:techbox/components/app_bar.dart';
import 'package:techbox/components/bottom_navigation.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  int _selectedIndex = 0;
  
 static const List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Shop Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Likes Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Cart Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(title: 'Thêm địa chỉ',),
      bottomNavigationBar: BottomNavigation(selectedIndex: _selectedIndex, 
        onTabChange: _onTabChange,
      ),
    );
  }
}