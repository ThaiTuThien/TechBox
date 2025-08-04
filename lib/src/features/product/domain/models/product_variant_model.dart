import 'package:equatable/equatable.dart';

class ProductVariantModel extends Equatable {
  final String id;
  final ColorModel color;
  final String product;
  final int rating;
  final String storage;
  final int price;
  final String status;
  final int stock;
  final String slug;
  final List<String> images;
  final List<String> reviews;

  const ProductVariantModel({
    required this.id,
    required this.color,
    required this.product,
    required this.rating,
    required this.storage,
    required this.price,
    required this.status,
    required this.stock,
    required this.slug,
    required this.images,
    required this.reviews
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['_id'], 
      color: ColorModel.fromJson(json['color']), 
      product: json['product'], 
      rating: json['rating'], 
      storage: json['storage'], 
      price: json['price'], 
      status: json['status'], 
      stock: json['stock_quantity'], 
      slug: json['slug'], 
      images: List<String>.from(json['images']),
      reviews: List<String>.from(json['reviews'])
    );
  }

  @override
  List<Object?> get props => [id, color, product, rating, storage, price, status, stock, slug, images, reviews];
}

class ColorModel extends Equatable{
  final String colorName;
  final String colorCode;

  const ColorModel({required this.colorName, required this.colorCode});

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      colorName: json['colorName'], 
      colorCode: json['colorCode']
    );
  }

  @override
  List<Object> get props => [colorName, colorCode];
}