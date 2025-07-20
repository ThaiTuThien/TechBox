import 'package:equatable/equatable.dart';

class OrderVariantDto extends Equatable{
  final String variant;
  final int quantity;

  const OrderVariantDto({
    required this.variant,
    required this.quantity
  });

  Map<String, dynamic> toJson() => {
    'variant': variant,
    'quantity': quantity
  };

  @override
  List<Object?> get props => [variant, quantity];
}