import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/login/data/data-source/login_data_source.dart';
import 'package:techbox/src/features/auth/login/data/dtos/login_dto.dart';
import 'package:techbox/src/features/auth/login/domain/models/login_model.dart';

class LoginRepo {
  final LoginDataSource _dataSource;

  LoginRepo(this._dataSource);

  Future<Either<String, LoginResponse>> login(LoginDto dto) async {
    try {
      final data = await _dataSource.login(dto);
      return Right(data);
    }
    catch (e) {
      return Left(e.toString());
    }
  }
}