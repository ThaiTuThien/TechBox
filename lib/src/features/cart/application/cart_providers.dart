import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/cart/application/cart_services.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';

final cartDataProvider = FutureProvider<List<CartItem>>((ref) async {
  final cartService = ref.read(cartServiceProvider);
  return await cartService.getCart();
});

final cartTotalProvider = FutureProvider<int>((ref) async {
  final cartService = ref.read(cartServiceProvider);
  return await cartService.getTotalPrice();
});
