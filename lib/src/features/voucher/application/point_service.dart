import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/voucher/data/repository/point_repository.dart';
import 'package:techbox/src/features/voucher/domain/point_model.dart';

class PointService {
  PointRepository _repository;
  PointService(this._repository);

  Future<Either<String, PointModel>> getPoints() async {
    try {
      return await _repository.getPoints();
    } catch (e) {
      return Left(e.toString());
    }
  }
}
