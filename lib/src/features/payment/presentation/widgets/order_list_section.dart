import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';
import 'package:techbox/src/features/payment/presentation/widgets/product_item.dart';
import 'package:techbox/src/utils/checkout_helpers.dart';

class OrderListSection extends StatelessWidget {
  final List<CartItem> cartItems;

  const OrderListSection({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: 'Danh sách đơn hàng'),
        const SizedBox(height: 12),
        if (cartItems.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Giỏ hàng trống',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          )
        else
          ...cartItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Column(
              children: [
                ProductItem(
                  productName: item.productName + " " + item.storage,
                  productColor: item.colorName,
                  colorValue: CheckoutHelpers.parseColor(item.colorCode),
                  price: item.price,
                  quantity: item.quantity,
                  imageUrl: item.imageUrl,
                ),
                if (index < cartItems.length - 1) _divider(),
              ],
            );
          }).toList(),
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
