import 'package:flutter/material.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/product_card.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/product_empty.dart';

class ProductFavoriteListPage extends StatelessWidget {
  final List<Product> favoriteProducts;

  const ProductFavoriteListPage({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    if (favoriteProducts.isEmpty) {
      return ProductEmptyFavorite();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16, 
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = favoriteProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}
