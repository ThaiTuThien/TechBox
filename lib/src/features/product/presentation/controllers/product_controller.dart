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
}

final productControllerProvider = StateNotifierProvider<ProductControllers, ProductState>((ref) {
  final datasource = ProductDataSource();
  final repo = ProductRepository(datasource);
  final services = ProductService(repo);
  return ProductControllers(services);
});