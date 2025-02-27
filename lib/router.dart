import 'package:go_router/go_router.dart';
import 'package:home_inventory_app/features/auth/presentation/pages/login_page.dart';
import 'package:home_inventory_app/features/auth/presentation/pages/register_page.dart';
import 'package:home_inventory_app/features/inventory/presentation/pages/inventory_detail_page.dart';
import 'package:home_inventory_app/features/inventory/presentation/pages/inventory_list_page.dart';
import 'package:home_inventory_app/features/inventory/presentation/pages/inventory_selection_page.dart';
import 'package:home_inventory_app/features/product/presentation/pages/product_form_page.dart';
import 'package:home_inventory_app/features/settings/presentation/pages/settings_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(
      path: '/create-inventory',
      builder: (context, state) => InventorySelectionPage(),
    ),
    GoRoute(
      path: '/inventory-list',
      builder: (context, state) => InventoryListPage(),
    ),
    GoRoute(
      path: '/inventory/:inventoryId/:inventoryName',
      builder: (context, state) {
        final inventoryId = state.pathParameters['inventoryId']!;
        final inventoryName = state.pathParameters['inventoryName']!;
        if (inventoryName.isEmpty) {
          return InventoryListPage();
        }
        return InventoryDetailPage(
          inventoryName: inventoryName,
          inventoryId: inventoryId,
        );
      },
    ),
    GoRoute(
      path: '/product-form',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ProductFormPage(
          inventoryId: extra?['inventoryId'],
          productId: extra?['productId'],
        );
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
