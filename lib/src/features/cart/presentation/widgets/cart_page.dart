import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_empty.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_product_item.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_bottom_section.dart';
import 'package:techbox/src/features/cart/data/mock_cart_data.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartProduct> cartProducts = [];

  @override
  void initState() {
    super.initState();
    // Load mock data - replace this with API call later
    _loadCartData();
  }

  void _loadCartData() {
    // TODO: Replace with API call
    // Example: cartProducts = await cartRepository.getCartItems();
    setState(() {
      cartProducts = MockCartData.getMockCartProducts();
    });
  }

  void _updateProductQuantity(String productId, int newQuantity) {
    setState(() {
      final index = cartProducts.indexWhere((product) => product.id == productId);
      if (index != -1) {
        cartProducts[index] = cartProducts[index].copyWith(quantity: newQuantity);
      }
    });
  }

  void _deleteProduct(String productId) {
    setState(() {
      final index = cartProducts.indexWhere((product) => product.id == productId);
      if (index != -1) {
        cartProducts[index] = cartProducts[index].copyWith(quantity: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeProducts = MockCartData.getActiveProducts(cartProducts);
    final totalPrice = MockCartData.getTotalPrice(cartProducts);
    final isCartEmpty = MockCartData.isCartEmpty(cartProducts);

    return isCartEmpty
        ? const CartEmpty()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarComponent(
              title: 'Giỏ Hàng',
              showBackButton: false,
              showBottomBorder: false,
              onBackPressed: () => Navigator.pop(context),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          ...activeProducts.map((product) => Column(
                            children: [
                              CartProductItem(
                                productId: product.id,
                                productName: product.name,
                                productColor: product.color,
                                colorValue: product.colorValue,
                                price: product.price,
                                quantity: product.quantity,
                                imageUrl: product.imageUrl,
                                onQuantityChanged: (newQuantity) {
                                  _updateProductQuantity(product.id, newQuantity);
                                },
                                onDelete: () {
                                  _deleteProduct(product.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Đã xóa sản phẩm ${product.color}')),
                                  );
                                },
                              ),
                              if (activeProducts.last != product) _divider(),
                            ],
                          )),
                          const SizedBox(height: 95),
                        ],
                      ),
                    ),
                  ),
                  CartBottomSection(totalPrice: totalPrice),
                ],
              ),
            ),
          );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 1, color: Color.fromARGB(255, 230, 230, 230)),
    );
  }
} 