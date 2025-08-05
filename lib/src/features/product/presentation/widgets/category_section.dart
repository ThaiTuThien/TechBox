import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/product/presentation/controllers/category_controller.dart';
import 'package:techbox/src/features/product/presentation/widgets/category_card.dart';

class CategorySection extends ConsumerStatefulWidget {
  const CategorySection({super.key});

  @override
  ConsumerState<CategorySection> createState() => _CategorySection();
}


class _CategorySection extends ConsumerState<CategorySection> {
  
  Future<void> onGetCategory() async {
    await ref.watch(categoryControllerProvider.notifier).fetchCategoriesAdmin();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh mục mua sắm',
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
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 1,
              child: CategoryCard(
                label: 'iPhone',
                imageUrl: 'assets/image/ip.png',
                onTap: () {},
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 3,
              child: CategoryCard(
                label: 'iPad',
                imageUrl: 'assets/image/ipad.png',
                onTap: () {},
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: CategoryCard(
                label: 'MacBook',
                imageUrl: 'assets/image/mac.png',
                onTap: () {},
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: CategoryCard(
                label: 'Watch',
                imageUrl: 'assets/image/watch.png',
                onTap: () {},
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: CategoryCard(
                label: 'Airpods',
                imageUrl: 'assets/image/airpod.png',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
