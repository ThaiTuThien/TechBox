import 'package:equatable/equatable.dart';

class StripeRefundDto extends Equatable{
  final String orderId;
  final String reason;

  const StripeRefundDto({
    required this.orderId,
    required this.reason
  });

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'reason': reason
  };

  @override
  List<Object?> get props => [orderId, reason];
}