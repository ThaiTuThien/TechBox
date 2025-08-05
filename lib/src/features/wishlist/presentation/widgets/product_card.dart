import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/utils/color_formatted.dart';
import 'package:techbox/src/utils/currency_formatted.dart';

class Product extends StatefulWidget {
  final String name;
  final String colorName;
  final String colorHex;
  final String storage;
  final int price;
  final String imageUrl;
  final int rating;
  final int reviews;

  const Product({
    super.key,
    required this.name,
    required this.colorName,
    required this.colorHex,
    required this.storage,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
  });

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  double _favScale = 1.0;
  double _cartScale = 1.0;
  bool _isFavorited = true; 

  void _animateFav() async {
    setState(() {
      _favScale = 1.2;
      _isFavorited = !_isFavorited; 
    });
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child:
                        widget.imageUrl.isNotEmpty
                            ? Image.network(
                              widget.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loading) {
                                if (loading == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                  size: 40,
                                );
                              },
                            )
                            : Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 40,
                              ),
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
                                color: Colors.black.withValues(alpha: .08),
                                blurRadius: 4.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: _isFavorited
                              ? const Icon(Icons.favorite, color: Colors.red, size: 20)
                              : const Icon(Icons.favorite_border, size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.name,
                      style: const TextStyle(
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
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: colorFromHex(widget.colorHex),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.colorName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.storage,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w600,
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
                          '${widget.rating} (${widget.reviews} đánh giá)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatCurrency(widget.price),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
