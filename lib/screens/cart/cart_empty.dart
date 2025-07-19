import 'package:flutter/material.dart';
import 'package:techbox/components/app_bar.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(showBackButton: false,),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/cart.png',
                width: 64,
                height: 64,
              ),
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