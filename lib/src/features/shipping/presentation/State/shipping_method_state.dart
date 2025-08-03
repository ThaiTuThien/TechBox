

import 'package:equatable/equatable.dart';
import 'package:techbox/src/features/shipping/domain/Models/shipping_method.dart';

abstract class ShippingMethodState extends Equatable{
  const ShippingMethodState();

  @override 
  List<Object?> get props => [];
}

class ShippingMethodInnitial extends ShippingMethodState {}

class ShippingMethodLoading extends ShippingMethodState {}

class ShippingMethodSuccess extends ShippingMethodState {
  final List<ShippingMethod> methods ; 

  const ShippingMethodSuccess(this.methods);

  @override
  List<Object> get props => [methods];
}

class ShippingMethodError extends ShippingMethodState {
  final String message ; 

  const ShippingMethodError(this.message);

  @override
  List<Object> get props => [message];
}