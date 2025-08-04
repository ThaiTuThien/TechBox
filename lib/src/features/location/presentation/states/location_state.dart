import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';
import 'package:equatable/equatable.dart'; 

sealed class LocationState extends Equatable {
  const LocationState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProvinceDto> provinces) success,
    required T Function(String message) error,
  });

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProvinceDto> provinces) success,
    required T Function(String message) error,
  }) {
    return initial();
  }

  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {
  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProvinceDto> provinces) success,
    required T Function(String message) error,
  }) {
    return loading();
  }

  @override
  List<Object?> get props => [];
}

class LocationSuccess extends LocationState {
  final List<ProvinceDto> provinces;

  LocationSuccess(this.provinces);

  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProvinceDto> provinces) success,
    required T Function(String message) error,
  }) {
    return success(provinces);
  }

  @override
  List<Object?> get props => [provinces];
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProvinceDto> provinces) success,
    required T Function(String message) error,
  }) {
    return error(message);
  }

  @override
  List<Object?> get props => [message];
}