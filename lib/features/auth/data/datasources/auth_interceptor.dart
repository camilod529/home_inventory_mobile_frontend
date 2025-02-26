import 'package:dio/dio.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_local_data_source.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource authLocalDataSource;

  AuthInterceptor(this.authLocalDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token =
        await authLocalDataSource.getToken(); // Obtener el token de Hive
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}
