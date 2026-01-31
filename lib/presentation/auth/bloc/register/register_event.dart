part of 'register_bloc.dart';

@freezed
abstract class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.submit({
    required String name,
    required String email,
    required String password,
  }) = _Submit;
}
