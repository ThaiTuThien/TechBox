import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/product/data/data-source/product_data_source.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:techbox/src/features/product/domain/models/slug_model.dart';

class ProductRepository {
  final ProductDataSource _dataSource;

  ProductRepository(this._dataSource);

  Future<Either<String, ProductResponse>> getAllProduct() async {
    try {
      final data = await _dataSource.getAllProduct();
      return Right(data);
    }
    catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SlugResponse>> getProductBySLug(String slug) async {
    try {
      final data = await _dataSource.getProductBySlug(slug);
      return Right(data);
    }
    catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductResponse>> getProductByCategoryId(String categoryId) async {
    try {
      final data = await _dataSource.getProductsByCategoryId(categoryId);
      return Right(data);
    }
    catch (e) {
      return Left(e.toString());
    }
  }
}