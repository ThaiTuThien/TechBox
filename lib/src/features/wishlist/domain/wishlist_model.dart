// file: lib/src/features/wishlist/domain/wishlist_model.dart

import 'package:equatable/equatable.dart';

class WishlistModel extends Equatable {
  final String variantId;
  final String productName; // Rất quan trọng để hiển thị tên
  final String imageUrl;
  final int price;
  final String colorName;
  final String colorCode;
  final String storage;
  final String slug; // Cần thiết để điều hướng

  const WishlistModel({
    required this.variantId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.colorName,
    required this.colorCode,
    required this.storage,
    required this.slug,
  });

  Map<String, dynamic> toJson() {
    return {
      'variantId': variantId,
      'productName': productName,
      'imageUrl': imageUrl,
      'price': price,
      'colorName': colorName,
      'colorCode': colorCode,
      'storage': storage,
      'slug': slug,
    };
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      variantId: json['variantId'] ?? '',
      productName: json['productName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? 0,
      colorName: json['colorName'] ?? '',
      colorCode: json['colorCode'] ?? '',
      storage: json['storage'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  @override
  List<Object> get props => [variantId]; 
}