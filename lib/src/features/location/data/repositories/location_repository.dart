import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';
import 'package:techbox/src/features/location/data/data-sources/location_data_source.dart';

class LocationRepository {
  final LocationDataSource _dataSource;

  LocationRepository(this._dataSource);

  Future<Either<String, List<ProvinceDto>>> getProvinces() async {
    try {
      final provinces = await _dataSource.getProvinces();
      return Right(provinces);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
