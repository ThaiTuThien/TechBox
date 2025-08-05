import 'package:equatable/equatable.dart';

class OrderVariant extends Equatable {
  final String variant;
  final int quantity;

  const OrderVariant({
    required this.variant,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'variant': variant,
    'quantity': quantity,
  };

  @override
  List<Object?> get props => [variant, quantity];
}

class CreateOrderRequest extends Equatable {
  final List<OrderVariant> variants;
  final int totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final String status;
  final String voucherCode;

  const CreateOrderRequest({
    required this.variants,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    required this.voucherCode,
  });

  Map<String, dynamic> toJson() => {
    'variants': variants.map((v) => v.toJson()).toList(),
    'totalAmount': totalAmount,
    'shippingAddress': shippingAddress,
    'paymentMethod': paymentMethod,
    'status': status,
    'voucherCode': voucherCode,
  };

  @override
  List<Object?> get props => [variants, totalAmount, shippingAddress, paymentMethod, status, voucherCode];
}

class CreateOrderResponse extends Equatable {
  final String message;
  final OrderData data;

  const CreateOrderResponse({
    required this.message,
    required this.data,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      message: json['message'] ?? '',
      data: OrderData.fromJson(json['data'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [message, data];
}

class OrderData extends Equatable {
  final String orderId;
  final List<OrderVariant> variants;

  const OrderData({
    required this.orderId,
    required this.variants,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    final variantsList = json['variants'] as List? ?? [];
    return OrderData(
      orderId: json['_id'] ?? json['orderId'] ?? '', // Map _id to orderId
      variants: variantsList
          .map((item) => OrderVariant(
                variant: item['variant'] ?? '',
                quantity: item['quantity'] ?? 0,
              ))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [orderId, variants];
}

class CreateCheckoutRequest extends Equatable {
  final String orderId;
  final List<OrderVariant> variants;

  const CreateCheckoutRequest({
    required this.orderId,
    required this.variants,
  });

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'variants': variants.map((v) => v.toJson()).toList(),
  };

  @override
  List<Object?> get props => [orderId, variants];
}

class CreateCheckoutResponse extends Equatable {
  final String message;
  final CheckoutData data;

  const CreateCheckoutResponse({
    required this.message,
    required this.data,
  });

  factory CreateCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CreateCheckoutResponse(
      message: json['message'] ?? '',
      data: CheckoutData.fromJson(json['data'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [message, data];
}

class CheckoutData extends Equatable {
  final String url;

  const CheckoutData({
    required this.url,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(
      url: json['url'] ?? '',
    );
  }

  @override
  List<Object?> get props => [url];
}

class UpdateOrderPaymentRequest extends Equatable {
  final String stripeSessionId;
  final String orderId;

  const UpdateOrderPaymentRequest({
    required this.stripeSessionId,
    required this.orderId,
  });

  Map<String, dynamic> toJson() => {
    'stripeSessionId': stripeSessionId,
    'orderId': orderId,
  };

  @override
  List<Object?> get props => [stripeSessionId, orderId];
}

class UpdateOrderPaymentResponse extends Equatable {
  final String message;
  final bool success;

  const UpdateOrderPaymentResponse({
    required this.message,
    required this.success,
  });

  factory UpdateOrderPaymentResponse.fromJson(Map<String, dynamic> json) {
    return UpdateOrderPaymentResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  @override
  List<Object?> get props => [message, success];
} 