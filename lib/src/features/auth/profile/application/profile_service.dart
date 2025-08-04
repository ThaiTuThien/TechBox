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

  Future<Either<String, void>> updateProfile(String name, String phoneNumber, String address) async {
    try {
      await _repository.updateProfile(name, phoneNumber, address);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}