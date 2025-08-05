import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/product/data/data-source/category_data_source.dart';
import 'package:techbox/src/features/product/domain/category_model.dart';

class CategoryRepository {
  final CategoryDataSource _dataSource;
  CategoryRepository(this._dataSource);

  Future<Either<Exception, List<CategoryModel>>> getCategories(String categoryId) async {
    try {
      final categories = await _dataSource.getCategories(categoryId);
      return Right(categories);
    } catch (e) {
      return Left(Exception('Repository error: $e'));
    }
  }

  Future<Either<Exception, List<CategoryModel>>> getCategoriesAdmin() async {
    try {
      final categories = await _dataSource.getCategoriesAdmin();
      return Right(categories);
    } catch (e) {
      return Left(Exception('Repository error: $e'));
    }
  }
}