import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/product/application/category_service.dart';
import 'package:techbox/src/features/product/data/data-source/category_data_source.dart';
import 'package:techbox/src/features/product/data/repository/category_repository.dart';
import 'package:techbox/src/features/product/presentation/states/category_state.dart';

class CategoryController extends StateNotifier<CategoryState>{
  final CategoryService _service;
  CategoryController(this._service) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    try {
      state = CategoryLoading();
      final result = await _service.getCategories();
      result.fold(
        (failure) => state = CategoryError(failure.toString()),
        (success) => state = CategorySuccess(success),
      );
    } catch (e){
      state = CategoryError('Unexpected Error: $e');
    }
  }
}

final categoryControllerProvider = StateNotifierProvider<CategoryController, CategoryState>((ref) {
  final dataSource = CategoryDataSource();
  final repository = CategoryRepository(dataSource);
  final service = CategoryService(repository);
  return CategoryController(service);
});