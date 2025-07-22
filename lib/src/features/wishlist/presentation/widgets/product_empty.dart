import 'package:flutter/material.dart';

class ProductEmptyFavorite extends StatelessWidget {
  const ProductEmptyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_outline, size: 64, color: Colors.grey.shade300),
          SizedBox(height: 16),
          Text(
            'Không có sản phẩm nào!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 26, 26, 26),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Bạn chưa có mục nào được lưu. Hãy quay lại trang chủ và thêm một vài mục.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
        ],
      ),
    );
  }
}
