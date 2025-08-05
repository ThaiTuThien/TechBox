import 'package:flutter/material.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/utils/currency_formatted.dart';

class OrderSummary extends StatelessWidget {
  final int subtotal;
  final int shippingFee;
  final int discount;
  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = subtotal + shippingFee - discount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chi tiết thanh toán',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSummaryRow(
                label: 'Tổng tiền hàng',
                value: formatCurrency(subtotal),
                color: const Color.fromARGB(225, 128, 128, 128),
              ),
              _buildSummaryRow(
                label: 'Phí vận chuyển',
                value: formatCurrency(shippingFee),
                color: const Color.fromARGB(225, 128, 128, 128),
              ),
              _buildSummaryRow(
                label: 'Giảm giá',
                value: '-${formatCurrency(discount)}',
                color: const Color.fromARGB(255, 16, 185, 129),
                isDiscount: true,
              ),
              const Divider(),
              _buildSummaryRow(
                label: 'Tổng thanh toán',
                value: formatCurrency(total),
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    Color? color,
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: color ?? ConstantsColor.colorMain,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color:
                  color ??
                  (isDiscount
                      ? const Color.fromARGB(255, 16, 185, 129)
                      : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
