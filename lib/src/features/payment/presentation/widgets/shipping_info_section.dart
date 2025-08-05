import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';
import 'package:techbox/src/features/payment/presentation/widgets/store_info.dart';
import 'package:techbox/src/utils/checkout_helpers.dart';

class ShippingInfoSection extends ConsumerWidget {
  const ShippingInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: 'Thông tin giao hàng'),
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, child) {
            final profileState = ref.watch(profileControllerProvider);
            return _buildStoreInfo(profileState, ref);
          },
        ),
        _divider(),
      ],
    );
  }

  Widget _buildStoreInfo(ProfileState profileState, WidgetRef ref) {
    return switch (profileState) {
      ProfileLoading() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đang tải thông tin...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vui lòng chờ trong giây lát',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      ProfileError(:final message) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Không thể tải thông tin địa chỉ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(profileControllerProvider.notifier).fetchProfile();
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Thử lại'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red.shade700,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
        ),
      ),

      ProfileSuccess(:final response) => StoreInfo(
        storeName: response.name.isNotEmpty ? response.name : 'Chưa có tên',
        storeAddress: CheckoutHelpers.formatAddress(response.address),
        onEditPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen()));
        },
      ),

      ProfileInitial() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đang tải thông tin...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vui lòng chờ trong giây lát',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    };
  }

  Widget _buildSectionTitle({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary, 
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        color: const Color.fromARGB(255, 230, 230, 230),
        height: 1,
      ),
    );
  }
} 