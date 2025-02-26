import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_inventory_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:home_inventory_app/injection.dart';
import 'package:home_inventory_app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(
                loginUseCase: sl(),
                registerUseCase: sl(),
                logoutUseCase: sl(),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}
