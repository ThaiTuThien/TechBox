import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/register/data/dtos/register_dto.dart';
import 'package:techbox/src/features/auth/register/data/repositories/register_repository.dart';

class RegisterService {
  final RegisterRepository _registerRepository;

  RegisterService(this._registerRepository);

  Future<Either<String, String>> register(RegisterDto dto) async {
    try {
      final data = await _registerRepository.register(dto);
      return data;
    }
    catch (e) {
      return Left(e.toString());
    }
  }
}