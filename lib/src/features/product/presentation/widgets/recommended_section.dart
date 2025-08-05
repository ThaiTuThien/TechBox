import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/presentation/controllers/product_controller.dart';
import 'package:techbox/src/features/product/presentation/states/product_state.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_card.dart';
import 'package:techbox/src/features/product/presentation/widgets/product_detail_screen.dart';

class RecommendedSection extends ConsumerStatefulWidget  {
  const RecommendedSection({super.key});

  @override
  ConsumerState<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends ConsumerState<RecommendedSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productControllerProvider.notifier).getAllProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productControllerProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đề xuất cho bạn',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Xem tất cả',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        _buildProductGrid(state),   
    ]);
  }
  Widget _buildProductGrid(ProductState state) {
    if (state is ProductLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is ProductError) {
      return Center(child: Text('Lỗi: ${state.message}'));
    }

    if (state is ProductSuccess) {
      final products = state.response.data;

      return GridView.builder(
        itemCount: products.length > 4 ? 4 : products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          if (product.variants.isEmpty) {
            return const SizedBox.shrink(); 
          }
          final firstVariant = product.variants.first;
          
          return ProductCard(
            product: product,
            variant: firstVariant,
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(slug: firstVariant.slug)));
              ref.read(productControllerProvider.notifier).getAllProduct();
            },
            
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
