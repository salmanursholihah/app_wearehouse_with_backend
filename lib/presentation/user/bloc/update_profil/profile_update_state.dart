// part of 'profile_update_bloc.dart';

// @freezed
// class ProfileUpdateState with _$ProfileUpdateState {
//   const factory ProfileUpdateState.initial() = _Initial;
// }



import 'package:app_wearehouse_with_backend/data/models/update_profile_response_model.dart';
import 'package:app_wearehouse_with_backend/data/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

