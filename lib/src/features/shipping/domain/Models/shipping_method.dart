import 'package:equatable/equatable.dart';

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
    return ShippingMethod(name: json ['name'], type: json ['type'], fee: json ['fee']);
  }

  @override
  List<Object?> get props => [name, type, fee] ;
}