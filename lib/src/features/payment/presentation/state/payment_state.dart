import 'package:equatable/equatable.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();

  @override
  List<Object?> get props => [];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateOrderSuccess extends PaymentState {
  final CreateOrderResponse response;

  const CreateOrderSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateCheckoutSuccess extends PaymentState {
  final CreateCheckoutResponse response;

  const CreateCheckoutSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateOrderPaymentSuccess extends PaymentState {
  final UpdateOrderPaymentResponse response;

  const UpdateOrderPaymentSuccess(this.response);

  @override
  List<Object?> get props => [response];
} 