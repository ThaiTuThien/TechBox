import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<ProvinceDto> provinces;

  LocationSuccess(this.provinces);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
