import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/cart/application/cart_providers.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';
import 'package:techbox/src/features/payment/presentation/widgets/checkout_screen.dart';
import 'package:techbox/src/utils/currency_formatted.dart';

class CartBottomSection extends ConsumerWidget {
  const CartBottomSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsync = ref.watch(cartDataProvider);
    final totalPriceAsync = ref.watch(cartTotalProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: cartItemsAsync.when(
          loading: () => const Row(
            children: [
              Expanded(child: Text('Đang tải...')),
              SizedBox(width: 16),
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
          error: (error, stack) => Row(
            children: [
              Expanded(
                child: Text(
                  'Lỗi: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(cartDataProvider),
                child: const Text('Thử lại'),
              ),
            ],
          ),
          data: (cartItems) => totalPriceAsync.when(
            loading: () => const Row(
              children: [
                Expanded(child: Text('Đang tính...')),
                SizedBox(width: 16),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ),
            error: (error, stack) => Row(
              children: [
                Expanded(
                  child: Text(
                    'Lỗi tính tiền: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(cartTotalProvider),
                  child: const Text('Thử lại'),
                ),
              ],
            ),
            data: (totalPrice) => Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Tổng tiền',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatCurrency(totalPrice),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                IntrinsicWidth(
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty ? null : () async {
                      ref.refresh(cartDataProvider);
                      ref.refresh(cartTotalProvider);
                      
                      await Future.delayed(const Duration(milliseconds: 100));
                      
                      final updatedCartItems = await ref.read(cartDataProvider.future);
                      final updatedTotalPrice = await ref.read(cartTotalProvider.future);
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            cartItems: updatedCartItems,
                            totalPrice: updatedTotalPrice,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cartItems.isEmpty ? Colors.grey : ConstantsColor.colorMain,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      minimumSize: const Size(0, 50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/checkpayment.png',
                          width: 17,
                          height: 17,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.payment,
                              size: 17,
                              color: Colors.white,
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          cartItems.isEmpty ? 'Giỏ hàng trống' : 'Thanh toán',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 