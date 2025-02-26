import 'package:dio/dio.dart';
import 'package:home_inventory_app/features/auth/data/models/auth_response_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AuthResponseModel> login(String email, String password) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return AuthResponseModel.fromJson(response.data);
  }

  Future<AuthResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {'fullName': name, 'email': email, 'password': password},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      //  Verifica el mensaje de error
      throw Exception("Error en el login: ${e.response?.data}");
    }
  }
}
