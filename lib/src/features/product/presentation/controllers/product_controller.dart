import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/product/application/product_service.dart';
import 'package:techbox/src/features/product/data/data-source/product_data_source.dart';
import 'package:techbox/src/features/product/data/repository/product_repository.dart';
import 'package:techbox/src/features/product/presentation/states/product_state.dart';

class ProductControllers extends StateNotifier<ProductState>{
  final ProductService _services;

  ProductControllers(this._services): super (ProductInitial());

  Future<void> getAllProduct() async {
    state = ProductLoading();
    final data = await _services.getAllProduct();
    data.fold(
      (err) => state = ProductError(err), 
      (res) => state = ProductSuccess(res)
    );
  }

  Future<void> getProductBySlug(String slug) async {
    state = ProductLoading();
    final data = await _services.getProductBySlug(slug);
    data.fold(
      (err) => state = ProductError(err), 
      (res) => state = ProductSlugSuccess(res)
    );
  }

  Future<void> getProductByCategoryId(String categoryId) async {
    state = ProductLoading();
    final data = await _services.getProductByCategoryId(categoryId);
    data.fold(
      (err) => state = ProductError(err), 
      (res) => state = ProductSuccess(res)
    );
  }
}

final productControllerProvider = StateNotifierProvider<ProductControllers, ProductState>((ref) {
  final datasource = ProductDataSource();
  final repo = ProductRepository(datasource);
  final services = ProductService(repo);
  return ProductControllers(services);
});

final recommendedProductsProvider = StateNotifierProvider<ProductControllers, ProductState>((ref) {
  final datasource = ProductDataSource(); // Giả sử bạn đã có provider cho datasource
  final repo = ProductRepository(datasource);
  final services = ProductService(repo);
  return ProductControllers(services);
});

final popularProductsProvider = StateNotifierProvider<ProductControllers, ProductState>((ref) {
  final datasource = ProductDataSource();
  final repo = ProductRepository(datasource);
  final services = ProductService(repo);
  return ProductControllers(services);
});

final productsProvider = StateNotifierProvider<ProductControllers, ProductState>((ref) {
  final datasource = ProductDataSource();
  final repo = ProductRepository(datasource);
  final services = ProductService(repo);
  return ProductControllers(services);
});