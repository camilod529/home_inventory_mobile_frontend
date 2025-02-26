import 'package:home_inventory_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:home_inventory_app/features/auth/domain/entities/user.dart';
import 'package:home_inventory_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    final authResponse = await remoteDataSource.login(email, password);
    await localDataSource.saveToken(authResponse.token);
    return authResponse.user;
  }

  @override
  Future<User> register(String name, String email, String password) async {
    final authResponse = await remoteDataSource.register(name, email, password);
    await localDataSource.saveToken(authResponse.token);
    return authResponse.user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearToken();
  }
}
