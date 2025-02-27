import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_inventory_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_inventory_app/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:home_inventory_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:home_inventory_app/features/settings/presentation/bloc/settings_bloc.dart';

import 'package:home_inventory_app/injection.dart';
import 'package:home_inventory_app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
        BlocProvider<InventoryBloc>(create: (context) => sl<InventoryBloc>()),
        BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
        BlocProvider<SettingsBloc>(create: (context) => sl<SettingsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Función para generar un MaterialColor a partir de un Color.
  MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final double r = color.r;
    final double g = color.g;
    final double b = color.b;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (r + ((ds < 0 ? r : (255 - r)) * ds)).round(),
        (g + ((ds < 0 ? g : (255 - g)) * ds)).round(),
        (b + ((ds < 0 ? b : (255 - b)) * ds)).round(),
        1,
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        bool isDarkMode = false;
        Color primaryColor = Colors.blue;
        if (state is SettingsLoaded) {
          isDarkMode = state.isDarkMode;
          primaryColor = state.color;
        }
        final themeData = ThemeData(
          primarySwatch: createMaterialColor(primaryColor),
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        );
        return MaterialApp.router(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          routerConfig: router,
        );
      },
    );
  }
}
