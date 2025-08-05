import 'package:equatable/equatable.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';
import 'package:techbox/src/features/product/domain/models/product_variant_model.dart';

class ProductResponse extends Equatable {
  final String message;
  final List<ProductModel> data;

  const ProductResponse({required this.message, required this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      message: json['message'],
      data:
          (json['data'] as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [message, data];
}

class ProductModel extends Equatable {
  final String id;
  final CategoryModel category;
  final String name;
  final String description;
  final List<ProductVariantModel> variants;

  const ProductModel({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.variants,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      category: CategoryModel.fromJson(json['category']),
      name: json['name'],
      description: json['description'],
      variants:
          (json['variants'] as List)
              .map((e) => ProductVariantModel.fromJson(e))
              .toList(),
    );
  }

  @override
  List<Object?> get props => [id, category, name, description, variants];
}
