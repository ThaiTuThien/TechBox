import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/register/data/data-sources/register_data_source.dart';
import 'package:techbox/src/features/auth/register/data/dtos/register_dto.dart';

class RegisterRepository {
  final RegisterDataSource _dataSource;

  RegisterRepository(this._dataSource);

  Future<Either<String, String>> register(RegisterDto dto) async {
    try {
      final data = await _dataSource.register(dto);
      return Right(data);
    }
    catch (e) {
      return Left(e.toString());
    }
  }
}