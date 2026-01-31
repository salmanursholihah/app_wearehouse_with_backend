import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/auth_response_model.dart';
import '../../core/local_storage.dart';

abstract class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  );

  Future<Either<String, String>> logout(String token);

  Future<Either<String, AuthResponseModel>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<String, String>> updateProfile({
    required String name,
    File? image,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  final Dio dio;

  static const baseUrl = 'http://192.168.1.13:8000/api';

  AuthRemoteDatasourceImpl(this.client)
      : dio = Dio(BaseOptions(baseUrl: baseUrl));

  // ======================
  // LOGIN
  // ======================
  @override
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final authResponse = AuthResponseModel.fromJson(body);

      await LocalStorage.saveToken(authResponse.token);

      return Right(authResponse);
    } else {
      return Left(body['message'] ?? 'Login gagal');
    }
  }

  // ======================
  // UPDATE PROFILE (FIX)
  // ======================
  @override
  Future<Either<String, String>> updateProfile({
    required String name,
    File? image,
  }) async {
    try {
      final token = await LocalStorage.getToken();

      final formData = FormData.fromMap({
        'name': name,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      await dio.put(
        '/profile',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      return const Right('Profile updated');
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? 'Gagal update profile',
      );
    }
  }

  // ======================
  // LOGOUT
  // ======================
  @override
  Future<Either<String, String>> logout(String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Right(body['message'] ?? 'Logout berhasil');
    } else {
      return Left(body['message'] ?? 'Logout gagal');
    }
  }

  // ======================
  // REGISTER
  // ======================
  @override
  Future<Either<String, AuthResponseModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(body));
    } else {
      return Left(body['message'] ?? 'Register gagal');
    }
  }
}
