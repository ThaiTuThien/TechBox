import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/product/data/repository/category_repository.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';

class CategoryService {
  final CategoryRepository _repository;
  CategoryService(this._repository);

  Future<Either<Exception, List<CategoryModel>>> getCategories(String categoryId) async {
    try {
      final result = await _repository.getCategories(categoryId);
      return result; 
    } catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }

  Future<Either<Exception, List<CategoryModel>>> getCategoriesAdmin() async {
    try {
      final result = await _repository.getCategoriesAdmin();
      return result; 
    } catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }
}
