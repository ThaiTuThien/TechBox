import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/verify_email/data/data-sources/verify_email_data_source.dart';
import 'package:techbox/src/features/auth/verify_email/domain/dtos/verify_email_dto.dart';

class VerifyEmailRepository {
  final VerifyEmailDataSource _dataSource;

  VerifyEmailRepository(this._dataSource);

  Future<Either<String,String>> verifyEmail(VerifyEmailDto dto) async {
    try{
      final data = await _dataSource.verifyEmail(dto);
      return Right(data);
    }
    catch(e) {
      return Left(e.toString());
    }
  }
}