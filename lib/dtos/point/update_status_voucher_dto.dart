import 'package:equatable/equatable.dart';

class UpdateStatusVoucherDto extends Equatable{
  final String voucherCode;
  final String orderId;

  const UpdateStatusVoucherDto({
    required this.voucherCode,
    required this.orderId
  });

  Map<String, dynamic> toJson() => {
    'voucherCode': voucherCode,
    'orderId': orderId
  };

  @override
  List<Object?> get props => [voucherCode, orderId];
}