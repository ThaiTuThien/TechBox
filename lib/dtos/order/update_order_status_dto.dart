import 'package:equatable/equatable.dart';

class UpdateOrderStatusDto extends Equatable{
  final String stripeSessionId;
  final String orderId;

  const UpdateOrderStatusDto({
    required this.stripeSessionId,
    required this.orderId
  });

  Map<String, dynamic> toJson() => {
    'stripeSessionId': stripeSessionId,
    'orderId': orderId
  };

  @override
  List<Object?> get props => [stripeSessionId, orderId];
}