import 'package:flutter/material.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';

class MockCartData {
  static const String baseImageUrl = 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iPhone-16/iphone-16-pro-max-2_1.jpg';

  static List<CartProduct> getMockCartProducts() {
    return [
      CartProduct(
        id: 'iphone_16_pro_max_256gb_navy_1',
        name: 'iPhone 16 Pro Max 256GB',
        color: 'Navy',
        colorValue: const Color(0xFF1E3A8A),
        price: 12000000,
        quantity: 1,
        imageUrl: baseImageUrl,
      ),
      CartProduct(
        id: 'iphone_16_pro_max_256gb_black_1',
        name: 'iPhone 16 Pro Max 256GB',
        color: 'Black',
        colorValue: Colors.black,
        price: 12000000,
        quantity: 1,
        imageUrl: baseImageUrl,
      ),
      CartProduct(
        id: 'iphone_16_pro_max_256gb_navy_2',
        name: 'iPhone 16 Pro Max 256GB',
        color: 'Navy',
        colorValue: const Color(0xFF1E3A8A),
        price: 12000000,
        quantity: 1,
        imageUrl: baseImageUrl,
      ),
      CartProduct(
        id: 'iphone_16_pro_max_512gb_silver_1',
        name: 'iPhone 16 Pro Max 512GB',
        color: 'Silver',
        colorValue: const Color(0xFFC0C0C0),
        price: 13500000,
        quantity: 2,
        imageUrl: baseImageUrl,
      ),
      CartProduct(
        id: 'iphone_16_pro_max_1tb_gold_1',
        name: 'iPhone 16 Pro Max 1TB',
        color: 'Gold',
        colorValue: const Color(0xFFFFD700),
        price: 15000000,
        quantity: 1,
        imageUrl: baseImageUrl,
      ),
    ];
  }

  // Helper method to get total price
  static int getTotalPrice(List<CartProduct> products) {
    return products.fold(0, (total, product) => total + (product.price * product.quantity));
  }

  // Helper method to check if cart is empty
  static bool isCartEmpty(List<CartProduct> products) {
    return products.every((product) => product.quantity == 0);
  }

  // Helper method to get products with quantity > 0
  static List<CartProduct> getActiveProducts(List<CartProduct> products) {
    return products.where((product) => product.quantity > 0).toList();
  }
} 