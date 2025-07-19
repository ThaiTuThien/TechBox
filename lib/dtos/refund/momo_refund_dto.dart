import 'package:equatable/equatable.dart';

class MomoRefundDto extends Equatable{
  final String orderId;
  final String reason;

  const MomoRefundDto({
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