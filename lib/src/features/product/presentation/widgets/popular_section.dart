import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/presentation/controllers/product_controller.dart';
import 'package:techbox/src/features/product/presentation/states/product_state.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_card.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_detail_screen.dart';

class PopularSection extends ConsumerStatefulWidget {
  const PopularSection({super.key});

  @override
  ConsumerState<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends ConsumerState<PopularSection> {
  String _selectedCategoryId = 'all'; 
  List<ProductModel> _allProducts = []; 
  List<CategoryModel> _uniqueCategories = []; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(popularProductsProvider.notifier).getAllProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(popularProductsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text('Phổ biến nhất', style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w700)),
                    TextButton(onPressed: () {}, child: Text('Xem tất cả', style: TextStyle(color: AppColors.primary))),
                ]
            )
        ),
        const SizedBox(height: 8),
         _buildContentBasedOnState(productState),
      ],
    );
  }

  Widget _buildContentBasedOnState(ProductState state) {
    return switch (state) {
      ProductLoading() => const Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),

      ProductError(:final message) => Center(child: Text('Lỗi: $message')),

      ProductSuccess(:final response) => _buildUIWithData(response.data),
      
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildUIWithData(List<ProductModel> products) {
    if (_allProducts.isEmpty) {
        _allProducts = products;
        _uniqueCategories = _extractUniqueCategories(products);
    }
    
    final filteredProducts = _filterProducts(_allProducts);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildFilterChips(_uniqueCategories),
            const SizedBox(height: 16),
            _buildGrid(filteredProducts),
        ],
    );
  }

  List<CategoryModel> _extractUniqueCategories(List<ProductModel> products) {
      final categoryMap = <String, CategoryModel>{};
      for (var product in products) {
        categoryMap[product.category.id!] = product.category;
      }
      return categoryMap.values.toList();
  }

  List<ProductModel> _filterProducts(List<ProductModel> allProducts) {
      if (_selectedCategoryId == 'all') {
          return allProducts; 
      }
      return allProducts.where((p) => p.category.id == _selectedCategoryId).toList();
  }
  
  Widget _buildFilterChips(List<CategoryModel> categories) {
    final allCategory = CategoryModel(id: 'all', name: 'Tất cả');
    final filters = [allCategory, ...categories];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final category = filters[index];
          final bool isSelected = category.id == _selectedCategoryId;
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
            child: GestureDetector(
              onTap: () {
                if (_selectedCategoryId != category.id) {
                  setState(() { _selectedCategoryId = category.id!; });
                }
              },
              child: Chip(
                  label: Text(category.name),
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600),
                  backgroundColor: isSelected ? AppColors.primary : Colors.white,
                  side: BorderSide(color: isSelected ? AppColors.primary : Colors.grey.shade300, width: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(List<ProductModel> products) {
    if (products.isEmpty) {
        return const Padding(padding: EdgeInsets.all(32.0), child: Center(child: Text('Không có sản phẩm trong danh mục này.')));
    }
    return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.55),
        itemBuilder: (context, index) {
            final product = products[index];
            if (product.variants.isEmpty) return const SizedBox.shrink();
            final variant = product.variants.first;
            return ProductCard(
                product: product,
                variant: variant,
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(slug: variant.slug)));
                });
        });
  }
}