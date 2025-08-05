import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/location/data/data-sources/location_data_source.dart';
import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';

class LocationRepository {
  final LocationDataSource _dataSource;

  LocationRepository(this._dataSource);

  Future<Either<String, List<Province>>> getProvinces() async {
    try {
      final data = await _dataSource.fetchProvinces();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<District>>> getDistricts(int provinceCode) async {
    try {
      final data = await _dataSource.fetchDistricts(provinceCode);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Ward>>> getWards(int districtCode) async {
    try {
      final data = await _dataSource.fetchWards(districtCode);
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
