import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/models/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;

  LoginBloc(this.datasource) : super(const LoginState.initial()) {
    on<_Login>((event, emit) async {
      emit(const LoginState.loading());

      final result = await datasource.login(
        event.email,
        event.password,
      );

      result.fold(
        (error) => emit(LoginState.error(error)),
        (data) => emit(LoginState.success(data)),
      );
    });
  }
}
