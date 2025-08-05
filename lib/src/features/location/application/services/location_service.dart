import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';
import 'package:techbox/src/features/location/data/repositories/location_repository.dart';

class LocationService {
  final LocationRepository _repository;

  LocationService(this._repository);

  Future<Either<String, List<Province>>> getProvinces() async {
    try {
      return await _repository.getProvinces();
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<District>>> getDistricts(int provinceCode) async {
    try {
      return await _repository.getDistricts(provinceCode);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Ward>>> getWards(int districtCode) async {
    try {
      return await _repository.getWards(districtCode);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
