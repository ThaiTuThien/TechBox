import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/product/data/repository/product_repository.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/domain/models/slug_model.dart';

class ProductService {
  final ProductRepository _repo;

  ProductService(this._repo);

  Future<Either<String, ProductResponse>> getAllProduct() async {
    try {
      return await _repo.getAllProduct();
    } 
    catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SlugResponse>> getProductBySlug(String slug) async {
    try {
      return await _repo.getProductBySLug(slug);
    } 
    catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductResponse>> getProductByCategoryId(String categoryId) async {
    try {
      return await _repo.getProductByCategoryId(categoryId);
    } 
    catch (e) {
      return Left(e.toString());
    }
  }
}