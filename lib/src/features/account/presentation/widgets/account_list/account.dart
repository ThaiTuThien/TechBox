import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

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
      // Sử dụng AppBarComponent thay vì AppBar mặc định
      appBar: const AppBarComponent(title: 'Tài Khoản'),

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
    );
  }
}
