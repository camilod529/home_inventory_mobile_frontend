import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_interceptor.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:home_inventory_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:home_inventory_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:home_inventory_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:home_inventory_app/features/auth/domain/usecases/login.dart';
import 'package:home_inventory_app/features/auth/domain/usecases/logout.dart';
import 'package:home_inventory_app/features/auth/domain/usecases/register.dart';
import 'package:home_inventory_app/features/auth/presentation/bloc/auth_bloc.dart';

// Importaciones del módulo de Inventario
import 'package:home_inventory_app/features/inventory/data/datasources/inventory_remote_data_source.dart';
import 'package:home_inventory_app/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:home_inventory_app/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:home_inventory_app/features/inventory/domain/usecases/get_user_inventories.dart';
import 'package:home_inventory_app/features/inventory/domain/usecases/create_inventory.dart';
import 'package:home_inventory_app/features/inventory/domain/usecases/join_inventory.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // ==============================
  // 🔹 Configuración Global
  // ==============================
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://172.16.99.31:3000/api'));
    dio.interceptors.add(AuthInterceptor(sl<AuthLocalDataSource>()));
    return dio;
  });

  // ==============================
  // 🔹 Autenticación
  // ==============================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton<Register>(() => Register(sl<AuthRepository>()));
  sl.registerLazySingleton<Logout>(() => Logout(sl<AuthRepository>()));

  sl.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: sl<Login>(),
      registerUseCase: sl<Register>(),
      logoutUseCase: sl<Logout>(),
    ),
  );

  // ==============================
  // 🔹 Inventario
  // ==============================
  sl.registerLazySingleton<InventoryRemoteDataSource>(
    () => InventoryRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(sl<InventoryRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetUserInventories>(
    () => GetUserInventories(sl<InventoryRepository>()),
  );
  sl.registerLazySingleton<CreateInventory>(
    () => CreateInventory(sl<InventoryRepository>()),
  );
  sl.registerLazySingleton<JoinInventory>(
    () => JoinInventory(sl<InventoryRepository>()),
  );

  sl.registerLazySingleton(
    () => InventoryBloc(
      getUserInventories: sl<GetUserInventories>(),
      createInventory: sl<CreateInventory>(),
      joinInventory: sl<JoinInventory>(),
    ),
  );
}
