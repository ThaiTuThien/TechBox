import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/profile/data/data-source/profile_data_source.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';

class ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepository(this._dataSource);

  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      final data = await _dataSource.getProfile();
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> updateProfile(String name, String phoneNumber, String address) async {
    try {
      await _dataSource.updateProfile(name, phoneNumber, address);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}