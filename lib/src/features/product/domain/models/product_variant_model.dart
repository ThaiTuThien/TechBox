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
  final List<ReviewModel> reviews;

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'product': product,
      'price': price,
      'rating': rating,
      'status': status,
      'storage': storage,
      'slug': slug,
      'images': images,
      'reviews': reviews,
      'stock': stock
    };
  }

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    var reviewsList = <ReviewModel>[];
    if (json['reviews'] != null) {
      json['reviews'].forEach((v) {
        reviewsList.add(ReviewModel.fromJson(v));
      });
    }

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
      reviews: reviewsList
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

class ReviewModel extends Equatable {
  final String id;
  final String variant;
  final int rating;
  final String comment;

  const ReviewModel({
    required this.id,
    required this.variant,
    required this.rating,
    required this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'],
      variant: json['variant'],
      rating: json['rating'],
      comment: json['comment'] ?? ""
    );
  }

  @override
  List<Object?> get props => [id, variant, rating, comment];
}