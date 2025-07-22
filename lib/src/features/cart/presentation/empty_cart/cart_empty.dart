import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(showBackButton: false),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey.shade300),
            SizedBox(height: 16),
            Text(
              'Giỏ hàng trống',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 26, 26, 26),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Hãy thêm sản phẩm vào giỏ hàng',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 128, 128, 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
