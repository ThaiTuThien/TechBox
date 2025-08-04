import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/address/presentation/update_address/update_address.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';
import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileControllerProvider.notifier).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileControllerProvider);
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
            child: _buildBody(state),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is ProfileError) {
      return Center(child: Text('Lỗi: ${state.message}'));
    }
    if (state is ProfileSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildUserProfileCard(state.response),
          const SizedBox(height: 24),
          _buildPersonalInfoSection(state.response),
          const SizedBox(height: 24),
          _buildAddressSection(state.response),
          const SizedBox(height: 60),
          _buildEditButton(context),
          const SizedBox(height: 16),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildUserProfileCard(ProfileModel profile) {
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
          _buildAvatar(profile.name),
          const SizedBox(width: 16),
          Expanded(child: _buildUserInfo(profile)),
        ],
      ),
    );
  }

  Widget _buildAvatar(String name) {
    String initials =
        name.isNotEmpty
            ? name.trim().split(' ').map((s) => s[0]).take(2).join()
            : 'NS';
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(ProfileModel profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profile.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.role,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Text(
          profile.address.street.isNotEmpty
              ? '${profile.address.street}, ${profile.address.ward}, ${profile.address.district},${profile.address.city}'
              : 'Chưa cập nhật',
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(ProfileModel profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Thông tin cá nhân'),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Họ và tên',
          profile.name,
          'Số điện thoại',
          profile.phoneNumber,
        ),
        const SizedBox(height: 16),
        _buildInfoRow('Email', profile.email, '', ''),
      ],
    );
  }

  Widget _buildAddressSection(ProfileModel profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Địa chỉ'),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Số nhà/Tên đường',
          profile.address.street,
          'Phường/Xã',
          profile.address.ward,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Quận/Huyện',
          profile.address.district,
          'Tỉnh/Thành phố',
          profile.address.city,
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
          value.isEmpty ? 'Chưa cập nhật' : value,
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
        onPressed: () async {
          final result = await Navigator.push;
          if (result == true) {
            ref.read(profileControllerProvider.notifier).fetchProfile();
          }
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
