import 'package:dio/dio.dart';

import '../../core/local_storage.dart';

class ChangePasswordRemoteDatasource {
  final Dio dio;

  ChangePasswordRemoteDatasource(this.dio);

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = await LocalStorage.getToken();

    final response = await dio.post(
      '/change-password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return response.data['message'];
  }
}
