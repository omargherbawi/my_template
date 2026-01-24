import '../../../../global_imports.dart';
import '../../feature/product/presentation/screens/product_screen.dart';
import '../../feature/splash_screen/splash_screen.dart';

GoRouter goRouters = GoRouter(
  navigatorKey: GlobalContext.navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.product,
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: AppRoutes.root, builder: (_, __) => const SplashScreen()),
    GoRoute(path: AppRoutes.product, builder: (context, state) => const ProductScreen()),
  ],
);
