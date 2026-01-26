import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../models/auth_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  );
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse('http://192.168.1.18:8000/api/login'),
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
      return Right(AuthResponseModel.fromJson(body));
    } else {
      return Left(body['message'] ?? 'Login gagal');
    }
  }
}
