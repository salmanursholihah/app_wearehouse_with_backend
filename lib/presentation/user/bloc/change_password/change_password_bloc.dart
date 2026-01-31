import 'package:app_wearehouse_with_backend/data/datasources/change_password_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRemoteDatasource datasource;

  ChangePasswordBloc(this.datasource)
      : super(ChangePasswordInitial()) {
    on<SubmitChangePassword>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitChangePassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());
    try {
      final message = await datasource.changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(ChangePasswordSuccess(message));
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}
