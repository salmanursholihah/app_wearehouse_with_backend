import 'package:app_wearehouse_with_backend/core/local_storage.dart';
import 'package:app_wearehouse_with_backend/data/datasources/about_us_remote_datasource.dart';
import 'package:app_wearehouse_with_backend/data/datasources/change_password_remote_datasource.dart';
import 'package:app_wearehouse_with_backend/data/datasources/update_profile_remote_datasource.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/about/about_bloc.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/update_profil/profile_update_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'presentation/user/bloc/request_to_admin/user_request_admin_bloc.dart';
import 'data/datasources/admin_request_remote_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// =====================
  /// BLOC
  /// =====================
  sl.registerFactory(
    () => UserRequestAdminBloc(
      sl<UserRequestAdminRemoteDatasource>(),
    ),
  );

sl.registerFactory(
    () => ProfileBloc(sl<ProfileRemoteDatasource>()),
  );


  /// =====================
  /// DATASOURCE
  /// =====================
  sl.registerLazySingleton<UserRequestAdminRemoteDatasource>(
    () => UserRequestAdminRemoteDatasource(
      sl<Dio>(),
    ),
  );


  sl.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(sl<Dio>()),
  );


sl.registerLazySingleton<AboutRemoteDatasource>(
  () => AboutRemoteDatasource(sl()),
);

sl.registerFactory(
  () => AboutBloc(sl()),
);


sl.registerLazySingleton(
    () => ChangePasswordRemoteDatasource(sl<Dio>()),
  );


  /// =====================
  /// DIO + AUTH INTERCEPTOR
  /// =====================
sl.registerLazySingleton<Dio>(() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.13:8000/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await LocalStorage.getToken();

        debugPrint('REQUEST => ${options.uri}');
        debugPrint('TOKEN => $token');

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
    ),
  );

  return dio;
});
}
