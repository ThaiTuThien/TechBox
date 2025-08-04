import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/address/presentation/update_address/update_address.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: 'Thông tin cá nhân',
        showBackButton: true,
        showBottomBorder: true,
      ),
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageTitle(),
                const SizedBox(height: 24),
                _buildUserProfileCard(),
                const SizedBox(height: 24),
                _buildPersonalInfoSection(),
                const SizedBox(height: 24),
                _buildAddressSection(),
                const SizedBox(height: 32),
                _buildEditButton(context),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Page Title Widget Function
  Widget _buildPageTitle() {
    return Text(
      'Hồ sơ của tôi',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ConstantsColor.colorMain,
      ),
    );
  }

  // User Profile Card Widget Function
  Widget _buildUserProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(),
          const SizedBox(width: 16),
          Expanded(child: _buildUserInfo()),
        ],
      ),
    );
  }

  // Avatar Widget Function
  Widget _buildAvatar() {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'NS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // User Info Widget Function
  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nam Sang',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text('User', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 8),
        Text(
          '563/95/6 Lê Văn Khương, Phường Hiệp Thành, Quận 12, Thành phố Hồ Chí Minh, Vietnam',
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin cá nhân'),
        const SizedBox(height: 16),
        _buildInfoRow('Họ và tên', 'Nam Sang', 'Số điện thoại', '0329703638'),
        const SizedBox(height: 16),
        _buildInfoRow('Email', 'namsang0902@gmail.com', '', ''),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Địa chỉ'),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Địa chỉ',
          '563/95/6 Lê Văn Khương',
          'Phường/Xã',
          'Phường Hiệp Thành',
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Quận',
          'Quận 12',
          'Tỉnh / Thành phố',
          'Thành phố Hồ Chí Minh',
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Row(
      children: [
        Expanded(child: _buildInfoItem(label1, value1)),
        if (label2.isNotEmpty) ...[
          const SizedBox(width: 16),
          Expanded(child: _buildInfoItem(label2, value2)),
        ],
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle edit button press
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateAddressPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ConstantsColor.colorMain,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
        child: const Text(
          'Chỉnh sửa thông tin',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
