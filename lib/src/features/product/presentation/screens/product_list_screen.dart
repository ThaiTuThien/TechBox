import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/presentation/controllers/product_controller.dart';
import 'package:techbox/src/features/product/presentation/states/product_state.dart';
import 'package:techbox/src/features/product/presentation/widgets/filter_bottom_sheet.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_card.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_detail_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  String _selectedCategoryId = 'all';
  List<ProductModel> _allProducts = [];
  List<CategoryModel> _uniqueCategories = [];
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productsProvider.notifier).getAllProduct();
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return const FilterBottomSheet();
      },
    );
  }

  List<CategoryModel> _extractUniqueCategories(List<ProductModel> products) {
    final categoryMap = <String, CategoryModel>{};
    for (var product in products) {
      categoryMap[product.category.id!] = product.category;
    }
    return categoryMap.values.toList();
  }

  List<ProductModel> _filterProducts() {
    List<ProductModel> byCategory;
    if (_selectedCategoryId == 'all') {
      byCategory = _allProducts;
    } else {
      byCategory =
          _allProducts
              .where((p) => p.category.id == _selectedCategoryId)
              .toList();
    }

    if (_searchQuery.trim().isEmpty) {
      return byCategory;
    } else {
      return byCategory
          .where(
            (p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(title: 'Danh sách sản phẩm', showBackButton: false),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),

            Consumer(
              builder: (context, ref, child) {
                final productState = ref.watch(productsProvider);
                return _buildContentBasedOnState(productState);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm sản phẩm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFFE6E6E6),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: _showFilterBottomSheet,
              icon: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentBasedOnState(ProductState state) {
    return switch (state) {
      ProductLoading() => const Expanded(
        child: Center(child: CircularProgressIndicator()),
      ),
      ProductError(:final message) => Expanded(
        child: Center(child: Text('Lỗi: $message')),
      ),
      ProductSuccess(:final response) => _buildUIWithData(response.data),
      _ => const Expanded(child: SizedBox.shrink()),
    };
  }

  Widget _buildUIWithData(List<ProductModel> products) {
    if (_allProducts.isEmpty) {
      _allProducts = products;
      _uniqueCategories = _extractUniqueCategories(products);
    }

    final filteredProducts = _filterProducts();
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  [
                    CategoryModel(id: 'all', name: 'Tất cả'),
                    ..._uniqueCategories,
                  ].length,
              itemBuilder: (context, index) {
                final filters = [
                  CategoryModel(id: 'all', name: 'Tất cả'),
                  ..._uniqueCategories,
                ];
                final category = filters[index];
                final bool isSelected = category.id == _selectedCategoryId;
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                    right: index == filters.length - 1 ? 16 : 0,
                  ),
                  child: ChoiceChip(
                    label: Text(category.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategoryId = category.id!);
                      }
                    },
                    showCheckmark: false,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color:
                            isSelected
                                ? AppColors.primary
                                : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildGrid(filteredProducts)),
        ],
      ),
    );
  }

  Widget _buildGrid(List<ProductModel> products) {
    if (products.isEmpty) {
      return const Center(child: Text('Không tìm thấy sản phẩm nào.'));
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        if (product.variants.isEmpty) return const SizedBox.shrink();
        final variant = product.variants.first;
        return ProductCard(
          product: product,
          variant: variant,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(slug: variant.slug),
              ),
            );
          },
        );
      },
    );
  }
}
