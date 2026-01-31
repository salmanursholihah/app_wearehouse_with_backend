// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'profile_update_event.dart';
// part 'profile_update_state.dart';
// part 'profile_update_bloc.freezed.dart';

// class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
//   ProfileUpdateBloc() : super(_Initial()) {
//     on<ProfileUpdateEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }


import 'package:app_wearehouse_with_backend/presentation/user/bloc/update_profil/profile_update_event.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/update_profil/profile_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/update_profile_remote_datasource.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRemoteDatasource datasource;

  ProfileBloc(this.datasource) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await datasource.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await datasource.updateProfile(
        name: event.name,
        image: event.image,
      );
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

