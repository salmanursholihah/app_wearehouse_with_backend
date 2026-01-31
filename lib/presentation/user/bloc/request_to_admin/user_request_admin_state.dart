// part of 'user_request_admin_bloc.dart';

// @freezed
// class UserRequestAdminState with _$UserRequestAdminState {
//   const factory UserRequestAdminState.initial() = _Initial;
// }



// presentation/user/bloc/user_request_admin_state.dart
import '../../../../data/models/user_request_to_admin_response_model.dart';

abstract class UserRequestAdminState {}

class UserRequestAdminInitial extends UserRequestAdminState {}

class UserRequestAdminLoading extends UserRequestAdminState {}

class UserRequestAdminSuccess extends UserRequestAdminState {
  final Userrequesttoadminresponsemodel response;

  UserRequestAdminSuccess(this.response);
}

class UserRequestAdminError extends UserRequestAdminState {
  final String message;

  UserRequestAdminError(this.message);
}
