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
    try {
      final result = await _service.getProfile();
      result.fold(
        (failure) {
          state = ProfileError(failure);
        },
        (success) {
          state = ProfileSuccess(success);
        },
      );
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phoneNumber,
    required String street,
    required String ward,
    required String district,
    required String city,
  }) async {
    try {
      final result = await _service.updateProfile(
        name: name,
        phoneNumber: phoneNumber,
        street: street,
        ward: ward,
        district: district,
        city: city,
      );

      await result.fold(
        (failure) async => throw Exception(failure),
        (success) async => await fetchProfile(),
      );
    } catch (e) {
      rethrow;
    }
  }
}

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
      final dataSource = ProfileDataSource();
      final repository = ProfileRepository(dataSource);
      final service = ProfileService(repository);
      return ProfileController(service);
    });
