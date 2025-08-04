import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/product/data/repository/category_repository.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';

class CategoryService {
  CategoryRepository _repository;
  CategoryService(this._repository);

  Future<Either<Exception, List<CategoryModel>>> getCategories() async {
    try {
      final result = await _repository.getCategories();
      return result; 
    } catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }
}
