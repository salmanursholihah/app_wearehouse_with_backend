import 'package:app_wearehouse_with_backend/data/models/auth_response_model.dart' show AuthResponseModel;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/datasources/auth_local_datasource.dart';


part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource remote;
  final AuthLocalDatasource local;

  RegisterBloc(this.remote, this.local)
      : super(const RegisterState.initial()) {
    on<_Submit>(_onSubmit);
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterState.loading());

    final result = await remote.register(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (error) {
        emit(RegisterState.error(error));
      },
      (authResponse) async {
        /// 🔐 SIMPAN TOKEN & ROLE
        await local.saveAuthData(
          token: authResponse.token,
          role: authResponse.user.role,
        );

        emit(RegisterState.success(authResponse));
      },
    );
  }
}
