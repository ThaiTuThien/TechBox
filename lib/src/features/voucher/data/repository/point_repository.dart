import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/voucher/data/data-source/point_data_source.dart';
import 'package:techbox/src/features/voucher/domain/point_model.dart';

class PointRepository {
  final PointDataSource _dataSource;

  PointRepository(this._dataSource);

  Future<Either<String, PointModel>> getPoints() async {
    try {
      final data = await _dataSource.getPoints();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
