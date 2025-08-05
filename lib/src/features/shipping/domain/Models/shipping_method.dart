import 'package:equatable/equatable.dart';

class ShippingMethodResponse extends Equatable {
  final String message;
  final ShippingMethodData data;

  const ShippingMethodResponse({
    required this.message,
    required this.data,
  });

  factory ShippingMethodResponse.fromJson(Map<String, dynamic> json) {
    return ShippingMethodResponse(
      message: json['message'] ?? '',
      data: ShippingMethodData.fromJson(json['data'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [message, data];
}

class ShippingMethodData extends Equatable {
  final List<ShippingMethod> methods;

  const ShippingMethodData({
    required this.methods,
  });

  factory ShippingMethodData.fromJson(Map<String, dynamic> json) {
    final methodsList = json['methods'] as List? ?? [];
    return ShippingMethodData(
      methods: methodsList
          .map((item) => ShippingMethod.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [methods];
}

class ShippingMethod extends Equatable{
  final String name ;
  final String type ;
  final int fee;

  ShippingMethod({
    required this.name,
    required this.type,
    required this.fee,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      name: json['name'] ?? '', 
      type: json['type'] ?? '', 
      fee: json['fee'] ?? 0
    );
  }

  @override
  List<Object?> get props => [name, type, fee] ;
}