import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/category_list.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/product_card.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/product_empty.dart';
import 'package:techbox/src/features/wishlist/presentation/widgets/product_list_favorite.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Map<String, List<Product>> favoriteProductsByCategory = {
    'iPhone': [
      Product(
        name: "iPhone 16 Pro Max",
        color: "Đen",
        storage: "256 GB",
        price: 28990000, 
        imageUrl:
            "https://www.apple.com/newsroom/images/2024/09/apple-debuts-iphone-16-pro-and-iphone-16-pro-max/article/Apple-iPhone-16-Pro-hero-240909_inline.jpg.large.jpg",
        rating: 4.9,
        reviews: 0,
      ),
      Product(
        name: "iPhone 16 Pro",
        color: "Đen",
        storage: "128 GB",
        price: 18990000,
        imageUrl:
            "https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iPhone-16/iphone-16-pro-max-2_1.jpg",
        rating: 4.8,
        reviews: 1,
      ),
    ],
    'iPad': [],
    'MacBook': [],
    'Watch': [],
    'AirPods': [],
  };

  String selected = 'iPhone';
  final List<String> categories = [
    'iPhone',
    'iPad',
    'MacBook',
    'Watch',
    'AirPods',
  ];

  @override
  Widget build(BuildContext context) {
    final products = favoriteProductsByCategory[selected] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
        title: 'Sản phẩm yêu thích',
        showBackButton: false,
        showBottomBorder: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        categories.map((title) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CategoryList(
                              title: title,
                              isSelected: selected == title,
                              onTap: () {
                                setState(() {
                                  selected = title;
                                });
                              },
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  products.isNotEmpty
                      ? ProductFavoriteListPage(favoriteProducts: products)
                      : ProductEmptyFavorite(),
            ),
          ],
        ),
      ),
    );
  }
}
