import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/login/data/dtos/login_dto.dart';
import 'package:techbox/src/features/auth/login/data/repository/login_repo.dart';
import 'package:techbox/src/features/auth/login/domain/models/login_model.dart';

class LoginService {
  final LoginRepo _repo;

  LoginService(this._repo);

  Future<Either<String, LoginResponse>> login(LoginDto dto) async {
    try {
      return await _repo.login(dto);
    }
    catch (e) {
      return Left(e.toString());
    }
  } 
}