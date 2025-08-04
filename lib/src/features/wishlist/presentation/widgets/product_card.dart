import 'package:flutter/material.dart';
import 'package:techbox/src/utils/currency_formatted.dart';

class Product {
  final String name;
  final String color;
  final String storage;
  final int price;
  final String imageUrl;
  final int rating;
  final int reviews;

  Product({
    required this.name,
    required this.color,
    required this.storage,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade500, width: 0.3),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              product.imageUrl,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 12, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(product.color, style: TextStyle(fontSize: 12)),
                      const Spacer(),
                      Text(product.storage, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(
                        "${product.rating} (${product.reviews} đánh giá)",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],  
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        formatCurrency(product.price),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.teal.shade900,
                        radius: 18,
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
