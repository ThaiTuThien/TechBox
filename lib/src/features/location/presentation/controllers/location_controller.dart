import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/location/application/services/location_service.dart';
import 'package:techbox/src/features/location/data/data-sources/location_data_source.dart';
import 'package:techbox/src/features/location/data/repositories/location_repository.dart';
import 'package:techbox/src/features/location/presentation/states/location_state.dart';

class LocationController extends StateNotifier<LocationState> {
  final LocationService _service;

  LocationController(this._service) : super(LocationInitial());

  Future<void> fetchProvinces() async {
    state = LocationLoading();
    try {
      final result = await _service.getProvinces();
      result.fold(
        (failure) => state = LocationError(failure.toString()),
        (provinces) => state = LocationSuccess(provinces),
      );
    } catch (e) {
      state = LocationError(e.toString());
    }
  }

  Future<void> fetchDistricts(int provinceCode) async {
    final currentState = state;
    if (currentState is LocationSuccess) {
      state = LocationLoading();
      try {
        final result = await _service.getDistricts(provinceCode);
        result.fold((failure) => state = LocationError(failure.toString()), (
          districts,
        ) {
          state = currentState.copyWith(
            districts: districts,
            selectedProvinceCode: provinceCode,
            wards: [],
            selectedDistrictCode: null,
            selectedDistrictName: null,
            selectedWardCode: null,
            selectedWardName: null,
          );
        });
      } catch (e) {
        state = LocationError(e.toString());
      }
    }
  }

  Future<void> fetchWards(int districtCode) async {
    final currentState = state;
    if (currentState is LocationSuccess) {
      state = LocationLoading();
      try {
        final result = await _service.getWards(districtCode);
        result.fold((failure) => state = LocationError(failure.toString()), (
          wards,
        ) {
          state = currentState.copyWith(
            wards: wards,
            selectedDistrictCode: districtCode,
            selectedWardCode: null,
            selectedWardName: null,
          );
        });
      } catch (e) {
        state = LocationError(e.toString());
      }
    }
  }

  void selectProvince(int? code) {
    if (state is LocationSuccess) {
      final currentState = state as LocationSuccess;
      final province = currentState.provinces.firstWhere(
        (p) => p.code == code,
        orElse: () => currentState.provinces.first,
      );
      state = currentState.copyWith(
        selectedProvinceCode: code,
        selectedProvinceName: province.name,
        districts: [],
        wards: [],
        selectedDistrictCode: null,
        selectedDistrictName: null,
        selectedWardCode: null,
        selectedWardName: null,
      );
    }
  }

  void selectDistrict(int? code) {
    if (state is LocationSuccess) {
      final currentState = state as LocationSuccess;
      if (currentState.districts != null) {
        final district = currentState.districts!.firstWhere(
          (d) => d.code == code,
          orElse: () => currentState.districts!.first,
        );
        state = currentState.copyWith(
          selectedDistrictCode: code,
          selectedDistrictName: district.name,
          wards: [],
          selectedWardCode: null,
          selectedWardName: null,
        );
      }
    }
  }

  void selectWard(int? code) {
    if (state is LocationSuccess) {
      final currentState = state as LocationSuccess;
      if (currentState.wards != null) {
        final ward = currentState.wards!.firstWhere(
          (w) => w.code == code,
          orElse: () => currentState.wards!.first,
        );
        state = currentState.copyWith(
          selectedWardCode: code,
          selectedWardName: ward.name,
        );
      }
    }
  }
}

final locationControllerProvider =
    StateNotifierProvider<LocationController, LocationState>((ref) {
      final dataSource = LocationDataSource();
      final repository = LocationRepository(dataSource);
      final service = LocationService(repository);
      return LocationController(service);
    });
