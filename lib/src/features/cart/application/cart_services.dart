import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';

class CartService {
  static const _cartKey = 'cart_items';

  Future<List<CartItem>> getCart() async {
    final pref = await SharedPreferences.getInstance();
    final cartString = pref.getString(_cartKey);
    if (cartString != null) {
      final List<dynamic> decodedList = jsonDecode(cartString);
      return decodedList.map((item) => CartItem.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> _saveCart(List<CartItem> cartItems) async {
    final pref = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> encodedList =
        cartItems.map((item) => item.toJson()).toList();
    await pref.setString(_cartKey, jsonEncode(encodedList));
  }

  Future<void> addToCart(CartItem newItem) async {
    final cartItems = await getCart();
    
    final existingItemIndex =
        cartItems.indexWhere((item) => item.variantId == newItem.variantId);
    
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity += newItem.quantity;
    } else {
      cartItems.add(newItem);
    }
    await _saveCart(cartItems);
  }  

  Future<void> updateItemQuantity(String variantId, int newQuantity) async {
    final cartItems = await getCart();
    final index = cartItems.indexWhere((item) => item.variantId == variantId);

    if (index != -1 && newQuantity > 0) {
      cartItems[index].quantity = newQuantity;
      await _saveCart(cartItems);
    }
  }

  Future<void> removeFromCart(String variantId) async {
    final cartItems = await getCart();
    cartItems.removeWhere((item) => item.variantId == variantId);
    await _saveCart(cartItems);
  }
}

final cartServiceProvider = Provider((ref) => CartService());