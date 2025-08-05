import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/payment/presentation/widgets/payment_method_item.dart';

class PaymentMethodSection extends StatelessWidget {
  final int selectedPaymentMethod;
  final Function(int) onPaymentMethodChanged;

  const PaymentMethodSection({
    Key? key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: 'Phương thức thanh toán'),
        const SizedBox(height: 12),
        PaymentMethodItem(
          methodName: 'Thanh toán với Stripe',
          iconAssetPath: 'assets/image/stripe.png',
          color: const Color.fromARGB(90, 99, 91, 255),
          containerBorderColor: const Color.fromARGB(255, 99, 91, 255),
          isSelected: selectedPaymentMethod == 0,
          onTap: () => onPaymentMethodChanged(0),
        ),
        PaymentMethodItem(
          methodName: 'Thanh toán với MoMo',
          iconAssetPath: 'assets/image/momo.png',
          color: const Color.fromARGB(90, 165, 0, 100),
          containerBorderColor: const Color.fromARGB(255, 165, 0, 100),
          isSelected: selectedPaymentMethod == 1,
          onTap: () => onPaymentMethodChanged(1),
        ),
        PaymentMethodItem(
          methodName: 'Thanh toán khi nhận hàng',
          iconAssetPath: 'assets/image/cash_on_delivery.png',
          color: const Color.fromARGB(90, 16, 185, 129),
          containerBorderColor: const Color.fromARGB(255, 16, 185, 129),
          isSelected: selectedPaymentMethod == 2,
          onTap: () => onPaymentMethodChanged(2),
        ),
        _divider(),
      ],
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