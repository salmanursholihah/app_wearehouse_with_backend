// part of 'profile_update_bloc.dart';

// @freezed
// class ProfileUpdateEvent with _$ProfileUpdateEvent {
//   const factory ProfileUpdateEvent.started() = _Started;
// }

import 'dart:io';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final File? image;

  UpdateProfile({
    required this.name,
    this.image,
  });
}
