import 'package:techbox/src/features/product/domain/models/product_model.dart';

sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final ProductResponse response;
  ProductSuccess(this.response);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}