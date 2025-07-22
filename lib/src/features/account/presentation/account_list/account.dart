import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static const List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.notifications_none,
      'title': 'Thông báo',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': Icons.person_outline,
      'title': 'Thông tin cá nhân',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': Icons.location_on_outlined,
      'title': 'Địa Chỉ',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': Icons.shopping_bag_outlined,
      'title': 'Đơn hàng của tôi',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': Icons.card_giftcard,
      'title': 'Đổi thẻ giảm giá',
      'color': 0xFF3C5A5D,
    },
    {
      'icon': Icons.confirmation_num_outlined,
      'title': 'Voucher của tôi',
      'color': 0xFF3C5A5D,
    },
    {'icon': Icons.settings_outlined, 'title': 'Cài Đặt', 'color': 0xFF3C5A5D},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarComponent(title: 'Tài Khoản', showBackButton: false),
      body: ListView.separated(
        itemCount: menuItems.length + 1,
        separatorBuilder:
            (context, index) => Column(
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade300,
                  indent: 16,
                  endIndent: 16,
                ),
                SizedBox(height: 8),
              ],
            ),

        itemBuilder: (context, index) {
          if (index < menuItems.length) {
            final item = menuItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Icon(item['icon'], size: 26, color: Color(item['color'])),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      item['title'],
                      style: const TextStyle(
                        color: Color(0xFF3C5A5D),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            );
          } else {
            return ListTile(
              leading: Icon(Icons.logout_outlined, color: Colors.red),
              title: const Text(
                'Đăng xuất',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
