import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/common_widgets/success_notification.dart';
import 'package:techbox/src/features/auth/login/presentation/widgets/login_screen.dart';
import 'package:techbox/src/features/auth/profile/presentation/widget/profile.dart';
import 'package:techbox/src/features/voucher/presentation/widget/voucher_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static const List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.notifications_none,
      'title': 'Thông báo',
      'color': 0xFF3C5A5D,
      'route': 'notifications',
    },
    {
      'icon': Icons.person_outline,
      'title': 'Thông tin cá nhân',
      'color': 0xFF3C5A5D,
      'route': 'profile',
    },
    {
      'icon': Icons.location_on_outlined,
      'title': 'Địa Chỉ',
      'color': 0xFF3C5A5D,
      'route': 'address',
    },
    {
      'icon': Icons.shopping_bag_outlined,
      'title': 'Đơn hàng của tôi',
      'color': 0xFF3C5A5D,
      'route': 'orders',
    },
    {
      'icon': Icons.card_giftcard,
      'title': 'Đổi thẻ giảm giá',
      'color': 0xFF3C5A5D,
      'route': 'gift_cards',
    },
    {
      'icon': Icons.confirmation_num_outlined,
      'title': 'Voucher của tôi',
      'color': 0xFF3C5A5D,
      'route': 'vouchers',
    },
    {
      'icon': Icons.settings_outlined,
      'title': 'Cài Đặt',
      'color': 0xFF3C5A5D,
      'route': 'settings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarComponent(title: 'Tài Khoản', showBackButton: false, showBottomBorder: false),
      body: SafeArea(
        child: ListView.separated(
          itemCount: menuItems.length + 1,
          separatorBuilder: (context, index) => _buildSeparator(),
          itemBuilder: (context, index) {
            if (index < menuItems.length) {
              return _buildMenuItem(context, menuItems[index]);
            } else {
              return _buildLogoutItem(context);
            }
          },
        ),
      ),
    );
  }

  // Menu Item Widget Function
  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () => _handleMenuItemTap(context, item),
      child: Padding(
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
      ),
    );
  }

  // Logout Item Widget Function
  Widget _buildLogoutItem(BuildContext context) {
    return InkWell(
      onTap: () => _handleLogout(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            const Icon(Icons.logout_outlined, size: 26, color: Colors.red),
            const SizedBox(width: 24),
            const Expanded(
              child: Text(
                'Đăng xuất',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Separator Widget Function
  Widget _buildSeparator() {
    return Column(
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade300,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Handle Menu Item Tap - ĐÂY LÀ NƠI BẠN THÊM NAVIGATION
  void _handleMenuItemTap(BuildContext context, Map<String, dynamic> item) {
    String route = item['route'];

    switch (route) {
      case 'notifications':
        Navigator.push;
        break;

      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;

      case 'address':
        Navigator.push;
        break;

      case 'orders':
        Navigator.push;
        break;

      case 'gift_cards':
        Navigator.push;
        break;

      case 'vouchers':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VoucherScreen()),
        );
        break;

      case 'settings':
        Navigator.push;
        break;

      default:
        // Fallback - show snackbar
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Đã chọn: ${item['title']}')));
    }
  }

  // Handle Logout Function
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                _performLogout(context);
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    //thêm logic logout sau nhé bạn Tấn

    SuccessNotification.show(
      context,
      subtitleText: 'Chúc mừng bạn đã đăng xuất thành công',
      buttonText: 'Quay về trang chủ',
      navigateToPage: LoginScreen(),
    );
  }
}
