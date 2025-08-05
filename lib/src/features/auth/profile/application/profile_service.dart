import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/auth/profile/data/repository/profile_repository.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';

class ProfileService {
  final ProfileRepository _repository;

  ProfileService(this._repository);

  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      return await _repository.getProfile();
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
      return await _repository.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        street: street,
        ward: ward,
        district: district,
        city: city,
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
