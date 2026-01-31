import 'dart:io';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../../core/local_storage.dart';

abstract class ProfileRemoteDatasource {
  ProfileRemoteDatasource(Dio dio);

  Future<UserModel> getProfile();
  Future<UserModel> updateProfile({
    required String name,
    File? image,
  });
}

// class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
//   final Dio dio;

//   ProfileRemoteDatasourceImpl(this.dio);

//   @override
//   Future<UserModel> getProfile() async {
//     final token = await LocalStorage.getToken();

//     final response = await dio.get(
//       '/profile',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     return UserModel.fromJson(response.data);
//   }

//   @override
//   Future<UserModel> updateProfile({
//     required String name,
//     File? image,
//   }) async {
//     final token = await LocalStorage.getToken();

//     final formData = FormData.fromMap({
//       'name': name,
//       if (image != null)
//         'image': await MultipartFile.fromFile(
//           image.path,
//           filename: image.path.split('/').last,
//         ),
//     });

//     final response = await dio.put(
//       '/profile',
//       data: formData,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     return UserModel.fromJson(response.data);
//   }
// }

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasourceImpl(this.dio);

  @override
  Future<UserModel> getProfile() async {
    final token = await LocalStorage.getToken();

    final response = await dio.get(
      '/profile',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateProfile({
    required String name,
    File? image,
  }) async {
    final token = await LocalStorage.getToken();

    final formData = FormData.fromMap({
      'name': name,
      '_method': 'PUT', // 🔥 FIX 405 LARAVEL
      if (image != null)
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });

    final response = await dio.post(
      '/profile',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return UserModel.fromJson(response.data);
  }
}