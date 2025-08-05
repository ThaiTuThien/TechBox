import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<Province> provinces;
  final List<District>? districts;
  final List<Ward>? wards;
  final int? selectedProvinceCode;
  final String? selectedProvinceName;
  final int? selectedDistrictCode;
  final String? selectedDistrictName;
  final int? selectedWardCode;
  final String? selectedWardName;

  LocationSuccess(
    this.provinces, {
    this.districts,
    this.wards,
    this.selectedProvinceCode,
    this.selectedProvinceName,
    this.selectedDistrictCode,
    this.selectedDistrictName,
    this.selectedWardCode,
    this.selectedWardName,
  });

  /// Creates a new instance of [LocationSuccess] with updated values.
  ///
  /// This method is crucial for immutable state management. It allows you to
  /// create a copy of the current state while changing only the properties
  /// you need, ensuring Riverpod detects the state change and rebuilds the UI.
  LocationSuccess copyWith({
    List<Province>? provinces,
    List<District>? districts,
    List<Ward>? wards,
    int? selectedProvinceCode,
    String? selectedProvinceName,
    int? selectedDistrictCode,
    String? selectedDistrictName,
    int? selectedWardCode,
    String? selectedWardName,
  }) {
    return LocationSuccess(
      provinces ?? this.provinces,
      districts: districts ?? this.districts,
      wards: wards ?? this.wards,
      selectedProvinceCode: selectedProvinceCode ?? this.selectedProvinceCode,
      selectedProvinceName: selectedProvinceName ?? this.selectedProvinceName,
      selectedDistrictCode: selectedDistrictCode ?? this.selectedDistrictCode,
      selectedDistrictName: selectedDistrictName ?? this.selectedDistrictName,
      selectedWardCode: selectedWardCode ?? this.selectedWardCode,
      selectedWardName: selectedWardName ?? this.selectedWardName,
    );
  }
}

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}
