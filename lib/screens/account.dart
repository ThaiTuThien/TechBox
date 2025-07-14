import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static const List<Map<String, dynamic>> menuItems = [
    {
      'icon': 'assets/image/bellaccount.png',
      'title': 'Thông Báo',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/details.png',
      'title': 'Thông Tin Chi Tiết',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/homeaccount.png',
      'title': 'Địa Chỉ',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/orderaccount.png',
      'title': 'Đơn Hàng Của Tôi',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/giftaccount.png',
      'title': 'Đổi Thẻ Giảm Giá',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/voucheraccount.png',
      'title': 'Voucher của tôi',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/privacypolicyaccount.png',
      'title': 'Chính Sách Bảo Mật',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': 'assets/image/settingaccount.png',
      'title': 'Cài Đặt',
      'color': 0xFF3C5A5D,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tài Khoản',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/image/back.png'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/image/bell.png',
              width: 28,
              height: 28,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: menuItems.length + 1,
        separatorBuilder:
            (context, index) => const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE0E0E0),
              indent: 16,
              endIndent: 16,
            ),
        itemBuilder: (context, index) {
          if (index < menuItems.length) {
            final item = menuItems[index];
            return ListTile(
              leading: Image.asset(
                item['icon'],
                width: 26,
                height: 26,
                fit: BoxFit.contain,
                // color: Color(item['color']), // Nếu icon là PNG trắng đen thì uncomment để đổi màu
              ),
              title: Text(
                item['title'],
                style: const TextStyle(
                  color: Color(0xFF3C5A5D),
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              trailing: Image.asset(
                'assets/image/chevronaccount.png',
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              minLeadingWidth: 32,
              onTap: () {},
            );
          } else {
            // Dòng cuối cùng: Đăng xuất
            return ListTile(
              leading: Image.asset(
                'assets/image/logoutaccount.png',
                width: 26,
                height: 26,
                color: Colors.red, // Nếu icon là PNG trắng đen
              ),
              title: const Text(
                'Đăng Xuất',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              minLeadingWidth: 32,
              onTap: () {},
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
