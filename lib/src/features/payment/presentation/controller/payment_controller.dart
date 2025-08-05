import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/payment/application/payment_service.dart';
import 'package:techbox/src/features/payment/data/data_source/payment_data_source.dart';
import 'package:techbox/src/features/payment/data/repository/payment_repository.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';
import 'package:techbox/src/features/payment/presentation/state/payment_state.dart';

class PaymentController extends StateNotifier<PaymentState> {
  final PaymentService _service;

  PaymentController(this._service) : super(PaymentInitial());

  Future<void> createOrder(CreateOrderRequest request) async {
    state = const PaymentLoading();
    final result = await _service.createOrder(request);
    result.fold(
      (failure) => state = PaymentError(failure.toString()),
      (success) => state = CreateOrderSuccess(success),
    );
  }

  Future<void> createCheckout(CreateCheckoutRequest request) async {
    state = const PaymentLoading();
    
    final result = await _service.createCheckout(request);
    
    result.fold(
      (error) => state = PaymentError(error.toString()),
      (response) => state = CreateCheckoutSuccess(response),
    );
  }

  Future<void> updateOrderPayment(UpdateOrderPaymentRequest request) async {
    state = const PaymentLoading();
    
    final result = await _service.updateOrderPayment(request);
    
    result.fold(
      (error) => state = PaymentError(error.toString()),
      (response) => state = UpdateOrderPaymentSuccess(response),
    );
  }
}

final paymentControllerProvider = StateNotifierProvider<PaymentController, PaymentState>((ref) {
  final dataSource = PaymentDataSource();
  final repository = PaymentRepository(dataSource);
  final service = PaymentService(repository);
  return PaymentController(service);
}); 