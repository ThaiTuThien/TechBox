import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'dart:async';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/domain/models/product_variant_model.dart';
import 'package:techbox/src/utils/color_formatted.dart';
import 'package:techbox/src/utils/currency_formatted.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final ProductVariantModel variant;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, required this.variant, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _favScale = 1.0;
  double _cartScale = 1.0;

  void _animateFav() async {
    setState(() => _favScale = 1.2);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _favScale = 1.0);
  }

  void _animateCart() async {
    setState(() => _cartScale = 1.2);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _cartScale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final variant = widget.variant;
    
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: variant.images.isNotEmpty
                       ? Image.network(variant.images.first, fit: BoxFit.cover, 
                            loadingBuilder: (context, child, loading) {
                              if (loading == null) return child;
                              return Center(child: CircularProgressIndicator());
                            }, 
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.image_not_supported, color: Colors.grey, size: 40);
                            })
                       : Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                       )
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _animateFav,
                      child: AnimatedScale(
                        scale: _favScale,
                        duration: const Duration(milliseconds: 120),
                        curve: Curves.easeOut,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 4.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.favorite_border, size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.circle, size: 10, color: colorFromHex(variant.color.colorCode)),
                  const SizedBox(width: 4),
                  Text(
                    variant.color.colorName,
                    style: TextStyle(fontSize: 12, color: Color(0xFF222222)),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Text(
                      variant.storage,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 4),
                   Text(
                    variant.reviews.length.toString(),
                    style: TextStyle(fontSize: 12, color: Color(0xFF222222)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatCurrency(variant.price),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0C1415),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _animateCart,
                    child: AnimatedScale(
                      scale: _cartScale,
                      duration: const Duration(milliseconds: 120),
                      curve: Curves.easeOut,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
