import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/product/data/repository/product_repository.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';

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
}