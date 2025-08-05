import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/features/cart/application/cart_services.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_empty.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_product_item.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_bottom_section.dart';
import 'package:techbox/src/utils/color_formatted.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  List<CartItem> cartProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    final items = await ref.read(cartServiceProvider).getCart();
    if (mounted) {
      setState(() {
        cartProducts = items;
        _isLoading = false;
      });
    }
  }
  Future<void> _handleQuantityChanged(String variantId, int newQuantity) async {
    await ref
        .read(cartServiceProvider)
        .updateItemQuantity(variantId, newQuantity);
    _loadCartData();
  }

  Future<void> _handleDelete(String variantId, String productName) async {
    await ref.read(cartServiceProvider).removeFromCart(variantId);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã xóa sản phẩm $productName')));
    _loadCartData(); 
  }

  int calTotalPrice() {
    if (cartProducts.isEmpty) return 0;
    return cartProducts.fold(
      0,
      (total, currentItem) =>
          total + (currentItem.price * currentItem.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (cartProducts.isEmpty) {
      return const CartEmpty();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
        title: 'Giỏ Hàng',
        showBackButton: false,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProducts[index];
                  return Dismissible(
                    key: Key(product.variantId),
                    direction:
                        DismissDirection
                            .endToStart, 
                    onDismissed: (direction) {
                      _handleDelete(product.variantId, product.productName);
                    },
                    // Background khi vuốt
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          CartProductItem(
                            productId: product.variantId,
                            productName: product.productName,
                            productColor: product.colorName,
                            price: product.price,
                            colorValue: colorFromHex(product.colorCode),
                            quantity: product.quantity,
                            imageUrl: product.imageUrl,
                            onQuantityChanged: (newQuantity) {
                              _handleQuantityChanged(
                                product.variantId,
                                newQuantity,
                              );
                            },
                            onDelete: () {
                              _handleDelete(
                                product.variantId,
                                product.productName,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          if (index < cartProducts.length - 1) _divider(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CartBottomSection(totalPrice: calTotalPrice()),
          ],
        ),
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, color: Color.fromARGB(255, 230, 230, 230));
}
