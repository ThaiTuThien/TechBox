import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';
import 'package:techbox/src/features/location/data/repositories/location_repository.dart';

class LocationService {
  final LocationRepository _locationRepository;

  LocationService(this._locationRepository);

  Future<Either<String, List<ProvinceDto>>> getProvinces() async {
    try {
      final provinces = await _locationRepository.getProvinces();
      return provinces;
    } catch (e) {
      return Left(e.toString());
    }
  }
}
