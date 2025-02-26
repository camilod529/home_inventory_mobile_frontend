import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:home_inventory_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_inventory_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:home_inventory_app/features/auth/domain/usecases/login.dart';
import 'package:home_inventory_app/features/auth/domain/usecases/logout.dart';
import 'package:home_inventory_app/features/auth/domain/usecases/register.dart';
import 'package:home_inventory_app/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Registering DIO
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: 'http://localhost:3000/api')),
  );

  // registering DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Registering repositories implementations
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // Registering use cases
  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton<Register>(() => Register(sl<AuthRepository>()));
  sl.registerLazySingleton<Logout>(() => Logout(sl<AuthRepository>()));

  // Registering blocs
  sl.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: sl<Login>(),
      registerUseCase: sl<Register>(),
      logoutUseCase: sl<Logout>(),
    ),
  );
}
