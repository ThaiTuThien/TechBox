import 'dart:ffi';
import 'package:equatable/equatable.dart';

class ProductVariantModel extends Equatable {
  final String id;
  final ColorModel color;
  final String product;
  final Int rating;
  final String storage;
  final Int price;
  final String status;
  final Int stock;
  final String slug;
  final List<String> images;

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
    required this.images
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
      stock: json['stock'], 
      slug: json['slug'], 
      images: List<String>.from(json['images'])
    );
  }

  @override
  List<Object?> get props => [id, color, product, rating, storage, price, status, stock, slug, images];
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