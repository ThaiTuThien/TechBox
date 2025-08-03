import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'package:techbox/src/features/shipping/data/Repositories/shipping_method_repository.dart';
import 'package:techbox/src/features/shipping/domain/Models/shipping_method.dart';


class ShippingMethodService {
  final ShippingMethodRepository _repository;

  ShippingMethodService(this._repository);

  Future<Either<Exception, List<ShippingMethod>>> calculateFee(CalculateFeeDto dto) async {
    try {
      final methods = await _repository.calculateFee(dto);
      return Right(methods as List<ShippingMethod>);
    } 
    catch (e) {
      return Left(Exception('Service error: $e'));
    }
  }
}