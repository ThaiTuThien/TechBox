import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'package:techbox/src/features/shipping/domain/Models/shipping_method.dart';
import 'package:techbox/src/features/shipping/presentation/Controller/shipping_method_controller.dart';
import 'package:techbox/src/features/shipping/presentation/State/shipping_method_state.dart';
import 'package:techbox/src/features/payment/presentation/widgets/shipping_method_item.dart';
import 'package:techbox/src/utils/checkout_helpers.dart';

class ShippingMethodSection extends ConsumerStatefulWidget {
  final int totalPrice;
  final Function(int) onShippingMethodChanged;
  final Function(int) onShippingFeeChanged;
  final int selectedShippingMethod;

  const ShippingMethodSection({
    Key? key,
    required this.totalPrice,
    required this.onShippingMethodChanged,
    required this.onShippingFeeChanged,
    required this.selectedShippingMethod,
  }) : super(key: key);

  @override
  ConsumerState<ShippingMethodSection> createState() => _ShippingMethodSectionState();
}

class _ShippingMethodSectionState extends ConsumerState<ShippingMethodSection> {
  List<ShippingMethod> shippingMethods = [];
  bool isShippingLoading = false;
  String? shippingError;

  @override
  void initState() {
    super.initState();
    _calculateShippingFee();
  }

  Future<void> _calculateShippingFee() async {
    try {
      setState(() {
        isShippingLoading = true;
        shippingError = null;
      });

      final profileState = ref.read(profileControllerProvider);
      if (profileState is ProfileSuccess) {
        final address = profileState.response.address;
        final shippingAddress = CheckoutHelpers.formatAddress(address);

        final dto = CalculateFeeDto(
          shippingAddress: shippingAddress,
          weight: _calculateTotalWeight(),
          height: 10,
          length: 20,
          width: 15,
          insuranceValue: widget.totalPrice,
        );

        await ref
            .read(shippingMethodControllerProvider.notifier)
            .calculateFee(dto);
      }
    } catch (e) {
      setState(() {
        shippingError = 'Không thể tính cước phí vận chuyển: $e';
      });
    } finally {
      setState(() {
        isShippingLoading = false;
      });
    }
  }

  int _calculateTotalWeight() {
    return 500;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: 'Phương thức vận chuyển'),
        const SizedBox(height: 12),
        Consumer(
          builder: (context, ref, child) {
            final profileState = ref.watch(profileControllerProvider);
            final shippingState = ref.watch(shippingMethodControllerProvider);

            if (profileState is ProfileSuccess &&
                shippingMethods.isEmpty &&
                !isShippingLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _calculateShippingFee();
              });
            }

            if (shippingState is ShippingMethodSuccess &&
                shippingMethods.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  shippingMethods = shippingState.response.data.methods;
                  widget.onShippingMethodChanged(0);
                  if (shippingMethods.isNotEmpty) {
                    widget.onShippingFeeChanged(shippingMethods[0].fee);
                  }
                });
              });
            }

            if (isShippingLoading) {
              return _buildLoadingState();
            }

            if (shippingError != null) {
              return _buildErrorState();
            }

            if (shippingMethods.isEmpty) {
              return _buildEmptyState();
            }

            return _buildShippingMethodsList();
          },
        ),
        _divider(),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text('Đang tính cước phí vận chuyển...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
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
              Icon(
                Icons.error_outline,
                color: Colors.red.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Lỗi tính cước phí',
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
            shippingError!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _calculateShippingFee,
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
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Vui lòng cập nhật địa chỉ để tính cước phí vận chuyển',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  Widget _buildShippingMethodsList() {
    final profileState = ref.read(profileControllerProvider);
    final isHCM = profileState is ProfileSuccess 
        ? CheckoutHelpers.isHoChiMinhCity(profileState.response.address)
        : false;

    return Column(
      children: shippingMethods.asMap().entries.map((entry) {
        final index = entry.key;
        final method = entry.value;

        if (method.type == 'super-express' && !isHCM) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            ShippingMethodItem(
              index: index,
              methodName: method.name,
              description: CheckoutHelpers.getShippingDescription(method.type),
              price: method.fee,
              color: CheckoutHelpers.getShippingColor(method.type),
              containerBorderColor: CheckoutHelpers.getShippingBorderColor(method.type),
              icon: CheckoutHelpers.getShippingIcon(method.type),
              isSelected: widget.selectedShippingMethod == index,
              onTap: () {
                widget.onShippingMethodChanged(index);
                widget.onShippingFeeChanged(method.fee);
              },
            ),
            if (index < shippingMethods.length - 1) const SizedBox(height: 4),
          ],
        );
      }).toList(),
    );
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