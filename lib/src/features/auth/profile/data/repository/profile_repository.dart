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

  Future<Either<String, void>> updateProfile({
    required String name,
    required String phoneNumber,
    required String street,
    required String ward,
    required String district,
    required String city,
  }) async {
    try {
      // TRUYỀN CÁC THAM SỐ ĐÃ ĐẶT TÊN
      await _dataSource.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        street: street,
        ward: ward,
        district: district,
        city: city,
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
