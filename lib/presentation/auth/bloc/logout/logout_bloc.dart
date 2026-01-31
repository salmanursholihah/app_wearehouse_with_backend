import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';

import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/datasources/auth_local_datasource.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource remote;
  final AuthLocalDatasource local;

  LogoutBloc(this.remote, this.local)
      : super(const LogoutState.initial()) {
    on<_Submit>((event, emit) async {
      emit(const LogoutState.loading());

      final token = await local.getToken();
      if (token == null) {
        emit(const LogoutState.success());
        return;
      }

      final result = await remote.logout(token);

      result.fold(
        (error) => emit(LogoutState.error(error)),
        (_) async {
          await local.clearAuthData();
          emit(const LogoutState.success());
        },
      );
    });
  }
}


