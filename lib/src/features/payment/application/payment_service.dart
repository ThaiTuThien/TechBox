import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/payment/data/repository/payment_repository.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';

class PaymentService {
  final PaymentRepository _repository;

  PaymentService(this._repository);

  Future<Either<Exception, CreateOrderResponse>> createOrder(CreateOrderRequest request) async {
    try {
      return await _repository.createOrder(request);
    } catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }

  Future<Either<Exception, CreateCheckoutResponse>> createCheckout(CreateCheckoutRequest request) async {
    try {
      return await _repository.createCheckout(request);
    } catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }

  Future<Either<Exception, UpdateOrderPaymentResponse>> updateOrderPayment(UpdateOrderPaymentRequest request) async {
    try {
      return await _repository.updateOrderPayment(request);
    } catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }
} 