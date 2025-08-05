import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/product/domain/models/product_variant_model.dart';
import 'package:techbox/src/features/product/presentation/controllers/product_controller.dart';
import 'package:techbox/src/features/product/presentation/states/product_state.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_image_carousel.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_variant_section.dart';
import 'package:techbox/src/utils/currency_formatted.dart';
import 'package:techbox/src/utils/html_formatted.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String slug;

  const ProductDetailScreen({super.key, required this.slug});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  ProductVariantModel? _selectedVariant;
  var _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(productControllerProvider.notifier)
          .getProductBySlug(widget.slug);
    });
  }

  void _incrementQuantity() {
    if (_selectedVariant != null && _quantity < _selectedVariant!.stock) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productControllerProvider);

    if (state is ProductLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProductError) {
      return Center(child: Text("Lỗi: ${state.message}"));
    }

    if (state is ProductSlugSuccess) {
      final productDetail = state.product.data;
      _selectedVariant ??= productDetail.variants.isNotEmpty 
                            ? productDetail.variants.first 
                            : null;
      if (_selectedVariant == null) {
        return const Scaffold(
          body: Center(child: Text("Sản phẩm không có biến thể nào.")),
        );
      }
  
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text(
            productDetail.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageCarousel(images: _selectedVariant!.images),
                const SizedBox(height: 24),
                Text(
                  _selectedVariant!.slug,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      _selectedVariant!.reviews.isEmpty
                          ? '0.0' 
                          : (_selectedVariant!.reviews.fold(0, (a, b) => a + b.rating) /
                                  _selectedVariant!.reviews.length).toStringAsFixed(1),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${_selectedVariant!.reviews.length} đánh giá)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ExpandableHtmlDescription(
                  htmlContent: productDetail.description
                ),
                const SizedBox(height: 24),
                ProductVariantSection(
                  variants: productDetail.variants,
                  currentVariant: _selectedVariant!,
                  onVariantSelected: (newVariant) {
                    setState(() {
                      _selectedVariant = newVariant;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Số lượng',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _quantity > 1 ? _decrementQuantity() : null;
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 20,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            _quantity.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                _quantity < _selectedVariant!.stock ? _incrementQuantity() : null;
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoChip(
                      context,
                      Icons.inventory_2_outlined,
                      'Kho',
                      '${_selectedVariant!.stock.toString()} sản phẩm',
                      const Color(0xFF2E7D32),
                      const Color(0xFFE8F5E9),
                    ),
                    _buildInfoChip(
                      context,
                      Icons.local_shipping_outlined,
                      'Giao',
                      'Giao trong 2h',
                      const Color(0xFFF57F17),
                      const Color(0xFFFFFDE7),
                    ),
                    _buildInfoChip(
                      context,
                      Icons.change_circle_outlined,
                      'Đổi trả',
                      'Lên đến 7 ngày',
                      const Color(0xFF0277BD),
                      const Color(0xFFE1F5FE),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Giá',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatCurrency(_selectedVariant!.price * _quantity),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Thêm vào giỏ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const Scaffold(body: Center(child: Text("Đang tải...")));
  }
}

Widget _buildInfoChip(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  Color color,
  Color backgroundColor,
) {
  return Container(
    width: MediaQuery.of(context).size.width / 3 - 22,
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
