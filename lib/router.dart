import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/auth/presentation/pages/login_page.dart';
import 'package:home_inventory_app/features/auth/presentation/pages/register_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
  ],
);
