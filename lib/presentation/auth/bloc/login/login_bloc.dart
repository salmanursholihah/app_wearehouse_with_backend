import 'package:app_wearehouse_with_backend/data/datasources/auth_local_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/models/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource remote;
  final AuthLocalDatasource local;

  LoginBloc(this.remote, this.local)
      : super(const LoginState.initial()) {
    on<_Login>((event, emit) async {
      emit(const LoginState.loading());

      final result = await remote.login(
        event.email,
        event.password,
      );

      await result.fold(
        (error) async {
          emit(LoginState.error(error));
        },
        (data) async {
          /// ✅ SIMPAN TOKEN & ROLE
          await local.saveAuthData(
            token: data.token,
            role: data.user.role,
          );

          emit(LoginState.success(data));
        },
      );
    });
  }
}
