// file: favorite_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/domain/models/product_variant_model.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_card.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_detail_screen.dart';
import 'package:techbox/src/features/wishlist/application/wishlist_service.dart';
import 'package:techbox/src/features/wishlist/domain/wishlist_model.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/product_empty.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  List<WishlistModel> _wishlistItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWishlistData();
  }

  Future<void> _loadWishlistData() async {
    final items = await ref.read(wishListServiceProvider).getWishList();
    if (mounted) {
      setState(() {
        _wishlistItems = items;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: 'Sản phẩm yêu thích', showBackButton: false),
      body: SafeArea(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_wishlistItems.isEmpty) return const ProductEmptyFavorite();

    return RefreshIndicator(
      onRefresh: _loadWishlistData,
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.55),
        itemCount: _wishlistItems.length,
        itemBuilder: (context, index) {
          final wishlistItem = _wishlistItems[index];

          final productForCard = ProductModel(
            id: '', name: wishlistItem.productName, description: '',
            category: CategoryModel(id: '', name: ''), variants: const [],
          );
          
          final variantForCard = ProductVariantModel(
            id: wishlistItem.variantId, product: '', status: '', stock: 0, rating: 0,
            color: ColorModel(colorName: wishlistItem.colorName, colorCode: wishlistItem.colorCode),
            storage: wishlistItem.storage,
            price: wishlistItem.price,
            slug: wishlistItem.slug, 
            images: [wishlistItem.imageUrl],
            reviews: const [],
          );
          
          return ProductCard(
            product: productForCard,
            variant: variantForCard,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(slug: variantForCard.slug)));
            },
          );
        },
      ),
    );
  }
}