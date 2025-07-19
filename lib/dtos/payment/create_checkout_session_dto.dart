import 'package:equatable/equatable.dart';
import 'package:techbox/dtos/order/order_variant_dto.dart';

class CreateCheckoutSessionDto extends Equatable{
  final String orderId;
  final List<OrderVariantDto> variants;

  const CreateCheckoutSessionDto({
    required this.orderId,
    required this.variants
  });

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'variants': variants.map((item) => item.props).toList()
  };

  @override
  List<Object?> get props => [orderId, variants];
}