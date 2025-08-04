import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel response;
  ProfileSuccess(this.response);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
