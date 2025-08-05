import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/payment/data/data_source/payment_data_source.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';

class PaymentRepository {
  final PaymentDataSource _dataSource;

  PaymentRepository(this._dataSource);

  Future<Either<Exception, CreateOrderResponse>> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _dataSource.createOrder(request);
      return Right(response);
    } catch (e) {
      return Left(Exception('Repository error: $e'));
    }
  }

  Future<Either<Exception, CreateCheckoutResponse>> createCheckout(CreateCheckoutRequest request) async {
    try {
      final response = await _dataSource.createCheckout(request);
      return Right(response);
    } catch (e) {
      return Left(Exception('Repository error: $e'));
    }
  }

  Future<Either<Exception, UpdateOrderPaymentResponse>> updateOrderPayment(UpdateOrderPaymentRequest request) async {
    try {
      final response = await _dataSource.updateOrderPayment(request);
      return Right(response);
    } catch (e) {
      return Left(Exception('Repository error: $e'));
    }
  }
} 