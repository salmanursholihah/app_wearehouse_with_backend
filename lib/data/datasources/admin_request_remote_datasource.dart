// data/datasource/user_request_admin_remote_datasource.dart
import 'package:dio/dio.dart';
import '../models/user_request_to_admin_response_model.dart';

class UserRequestAdminRemoteDatasource {
  final Dio dio;

  UserRequestAdminRemoteDatasource(this.dio);

  Future<Userrequesttoadminresponsemodel> requestAdmin() async {
    final response = await dio.post('/request-admin');

    return Userrequesttoadminresponsemodel.fromMap(response.data);
  }
}
