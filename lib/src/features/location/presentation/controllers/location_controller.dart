import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/location/application/services/location_service.dart';
import 'package:techbox/src/features/location/data/data-sources/location_data_source.dart';
import 'package:techbox/src/features/location/data/repositories/location_repository.dart';
import 'package:techbox/src/features/location/presentation/states/location_state.dart';

class LocationController extends StateNotifier<LocationState> {
  final LocationService _service;

  LocationController(this._service) : super(LocationInitial());

  Future<void> getProvinces() async {
    state = LocationLoading();
    final result = await _service.getProvinces();
    result.fold(
      (error) => state = LocationError(error),
      (provinces) => state = LocationSuccess(provinces),
    );
  }
}

final locationControllerProvider =
    StateNotifierProvider<LocationController, LocationState>((ref) {
      final dataSource = LocationDataSource();
      final repository = LocationRepository(dataSource);
      final service = LocationService(repository);
      return LocationController(service);
    });
