import 'package:equatable/equatable.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';
import 'package:techbox/src/features/product/domain/models/product_variant_model.dart';

class SlugResponse extends Equatable {
  final String message;
  final SlugModel data;

  const SlugResponse({required this.message, required this.data});

  factory SlugResponse.fromJson(Map<String, dynamic> json) {
    return SlugResponse(
      message: json['message'],
      data: SlugModel.fromJson(json['data'] as Map<String,dynamic>)
    );
  }
  @override
  List<Object?> get props => [message, data];
}

class SlugModel extends Equatable{
  final String id;
  final String name;
  final String description;
  final CategoryModel category;
  final List<ProductVariantModel> variants;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SlugModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.variants,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SlugModel.fromJson(Map<String, dynamic> json) {
    return SlugModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      category: CategoryModel.fromJson(json['category']),
      variants: (json['variants'] as List)
          .map((v) => ProductVariantModel.fromJson(v))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [id, name, description, category, variants, createdAt, updatedAt];
} 