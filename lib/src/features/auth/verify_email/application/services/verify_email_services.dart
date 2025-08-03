import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/verify_email/data/repository/verify_email_repository.dart';
import 'package:techbox/src/features/auth/verify_email/domain/dtos/verify_email_dto.dart';

class VerifyEmailServices {
  final VerifyEmailRepository _repository;

  VerifyEmailServices(this._repository);

  Future<Either<String,String>> verifyEmail(VerifyEmailDto dto) async {
    try {
      return await _repository.verifyEmail(dto);
    }
    catch(e) {
      return Left(e.toString());
    }
  }
}