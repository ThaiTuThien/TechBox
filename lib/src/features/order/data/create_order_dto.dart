import 'package:equatable/equatable.dart';
import 'package:techbox/src/features/order/data/order_variant_dto.dart';

class CreateOrderDto extends Equatable{
  final List<OrderVariantDto> variants;
  final int totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final String status;
  final String? voucherCode;

  const CreateOrderDto({
    required this.variants,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    this.voucherCode = ""
  });

  Map<String, dynamic> toJson() => {
    'variants': variants.map((item) => item.toJson()).toList(),
    'totalAmount': totalAmount,
    'shippingAddress': shippingAddress,
    'paymentMethod': paymentMethod,
    'status': status,
    'voucherCode': voucherCode ?? ""
  };

  @override
  List<Object?> get props => [variants, totalAmount, shippingAddress, paymentMethod, status, voucherCode];
}