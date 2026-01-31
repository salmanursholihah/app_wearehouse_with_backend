// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user_request_admin_event.dart';
// part 'user_request_admin_state.dart';
// part 'user_request_admin_bloc.freezed.dart';

// class UserRequestAdminBloc extends Bloc<UserRequestAdminEvent, UserRequestAdminState> {
//   UserRequestAdminBloc() : super(_Initial()) {
//     on<UserRequestAdminEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }


// presentation/user/bloc/user_request_admin_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/admin_request_remote_datasource.dart';
import 'user_request_admin_event.dart';
import 'user_request_admin_state.dart';

class UserRequestAdminBloc
    extends Bloc<UserRequestAdminEvent, UserRequestAdminState> {
  final UserRequestAdminRemoteDatasource datasource;

  UserRequestAdminBloc(this.datasource)
      : super(UserRequestAdminInitial()) {
    on<SubmitUserRequestAdmin>((event, emit) async {
      emit(UserRequestAdminLoading());

      try {
        final response = await datasource.requestAdmin();
        emit(UserRequestAdminSuccess(response));
      } catch (e) {
        emit(UserRequestAdminError(e.toString()));
      }
    });
  }
}
