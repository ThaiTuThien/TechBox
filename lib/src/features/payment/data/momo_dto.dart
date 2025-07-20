import 'package:equatable/equatable.dart';

class MomoDto extends Equatable{
  final String orderId;
  final int amount;
  final String orderInfo;

  const MomoDto({
    required this.orderId,
    required this.amount,
    required this.orderInfo
  });

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'amount': amount,
    'orderInfo': orderInfo
  };

  @override
  List<Object?> get props => [orderId, amount, orderInfo];
}