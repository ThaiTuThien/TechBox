import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/auth/profile/application/profile_service.dart';
import 'package:techbox/src/features/auth/profile/data/data-source/profile_data_source.dart';
import 'package:techbox/src/features/auth/profile/data/repository/profile_repository.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';
import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';

class ProfileController extends StateNotifier<ProfileState> {
  final ProfileService _service;

  ProfileController(this._service) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    state = ProfileLoading();
    print('Fetching profile started...');
    try {
      final result = await _service.getProfile();
      result.fold(
        (failure) {
          print('Fetch profile failed: $failure');
          state = ProfileError(failure); // Xử lý lỗi với String
        },
        (success) {
          print('Fetch profile success: $success');
          state = ProfileSuccess(success); // Xử lý ProfileModel
        },
      );
    } catch (e, stackTrace) {
      print('Unexpected error in fetchProfile: $e\nStackTrace: $stackTrace');
      state = ProfileError(e.toString());
    }
  }

  Future<void> updateProfile(String name, String phoneNumber, String address) async {
    state = ProfileLoading();
    print('Updating profile started...');
    try {
      final result = await _service.updateProfile(name, phoneNumber, address);
      result.fold(
        (failure) {
          print('Update profile failed: $failure');
          state = ProfileError(failure);
        },
        (success) {
          print('Update profile success');
          fetchProfile(); // Reload profile
          state = ProfileSuccess(ProfileModel(
            id: '',
            name: name,
            email: '',
            phoneNumber: phoneNumber,
            address: Address(
              street: address.split(',')[0].trim(),
              ward: address.split(',').length > 1 ? address.split(',')[1].trim() : '',
              district: address.split(',').length > 2 ? address.split(',')[2].trim() : '',
              city: address.split(',').length > 3 ? address.split(',')[3].trim() : '',
              country: '',
            ),
            role: '',
          ));
        },
      );
    } catch (e, stackTrace) {
      print('Unexpected error in updateProfile: $e\nStackTrace: $stackTrace');
      state = ProfileError(e.toString());
    }
  }
}

final profileControllerProvider = StateNotifierProvider<ProfileController, ProfileState>((ref) {
  final dataSource = ProfileDataSource();
  final repository = ProfileRepository(dataSource);
  final service = ProfileService(repository);
  return ProfileController(service);
});