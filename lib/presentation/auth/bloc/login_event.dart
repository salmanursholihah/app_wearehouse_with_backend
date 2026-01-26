part of 'login_bloc.dart';

@freezed
abstract class LoginEvent with _$LoginEvent {
  const factory LoginEvent.login(
    String email,
    String password,
  ) = _Login;
}