import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthData({
    required String token,
    required String role,
  });

  Future<String?> getToken();
  Future<String?> getRole();
  Future<void> clearAuthData();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage storage;
  AuthLocalDatasourceImpl(this.storage);

  static const _tokenKey = 'auth_token';
  static const _roleKey = 'auth_role';

  @override
  Future<void> saveAuthData({
    required String token,
    required String role,
  }) async {
    await storage.write(key: _tokenKey, value: token);
    await storage.write(key: _roleKey, value: role);
  }

  @override
  Future<String?> getToken() => storage.read(key: _tokenKey);

  @override
  Future<String?> getRole() => storage.read(key: _roleKey);

  @override
  Future<void> clearAuthData() async {
    await storage.delete(key: _tokenKey);
    await storage.delete(key: _roleKey);
  }
}
