import 'dart:ui';
import 'package:flutter/material.dart';

class CarouselItem {
  final String title;
  final String description;
  final String buttonText;
  final Color backgroundColor;
  final Widget innerImage;
  final Widget? image;

  CarouselItem({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.backgroundColor,
    required this.innerImage,
    this.image,
  });
}

final List<CarouselItem> carouselItems = [
  CarouselItem(
    title: 'Bộ sưu tập mới',
    description: '🔥 Giảm 50% cho đơn hàng đầu tiên',
    buttonText: 'Mua ngay',
    backgroundColor: Colors.white,
    innerImage: Image.asset('assets/image/phones.png', height: 130),
    image: Image.asset('assets/image/carousel1.png', fit: BoxFit.cover),
  ),
  CarouselItem(
    title: 'Miễn phí vận chuyển',
    description: '🚚 Cho đơn hàng tối thiểu – không giới hạn',
    buttonText: 'Mua sắm ngay',
    backgroundColor: const Color(0xFFD6EDE6),
    innerImage: Image.asset('assets/image/free_shipping.png', height: 130),
    image: Image.asset('assets/image/carousel2.png', fit: BoxFit.cover),
  ),
  CarouselItem(
    title: 'Quà cho người mới',
    description: '🎉 Nhận thẻ giảm giá cho đơn mua đầu tiên',
    buttonText: 'Nhận ngay',
    backgroundColor: const Color(0xFFD6EDE6),
    innerImage: Image.asset('assets/image/gifts.png', height: 130),
    image: Image.asset('assets/image/carousel2.png', fit: BoxFit.cover),
  ),
];
