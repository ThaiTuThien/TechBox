import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final String? id ;
  final String name;
  final String? parentCategory;

  const CategoryModel({
    this.id,
    required this.name,
    this.parentCategory,
  });

  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      id : json ['_id'],
      name : json ['name'],
      parentCategory: json ['parent_category'],
    );
  }

  @override
  List<Object?> get props => [id, name, parentCategory];
}