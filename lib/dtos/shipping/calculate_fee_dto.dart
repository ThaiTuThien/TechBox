import 'package:equatable/equatable.dart';

class CalculateFeeDto extends Equatable {
  final String shippingAddress;
  final int weight;
  final int height;
  final int length;
  final int width;
  final int insuranceValue;

  const CalculateFeeDto({
    required this.shippingAddress,
    required this.weight,
    required this.height,
    required this.length,
    required this.width,
    required this.insuranceValue
  });

  Map<String, dynamic> toJson() => {
    'shippingAddress': shippingAddress,
    'weight': weight,
    'height': height,
    'length': length,
    'width': width,
    'insuranceValue': insuranceValue
  };

  @override
  List<Object?> get props => [shippingAddress, weight, height, length, width, insuranceValue];
}