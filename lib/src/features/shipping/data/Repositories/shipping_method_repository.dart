import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/shipping/data/Data%20sources/shipping_method_data_source.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'package:techbox/src/features/shipping/domain/Models/shipping_method.dart';

class ShippingMethodRepository {
  final ShippingMethodDataSource _dataSource;

  ShippingMethodRepository(this._dataSource);

  Future<Either<Exception, ShippingMethodResponse>> calculateFee(CalculateFeeDto dto) async {
    try {
      final response = await _dataSource.calculateFee(dto);
      return Right(response);
    } catch (e) {
      return Left(Exception('Repository error: $e'));
    }
  }
}

