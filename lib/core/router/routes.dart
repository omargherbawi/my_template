import '../../../../global_imports.dart';
import '../../feature/character/presentation/screens/character_list_screen.dart';
import '../../feature/character/presentation/screens/character_detail_screen.dart';

GoRouter goRouters = GoRouter(
  navigatorKey: GlobalContext.navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.characters,
  routes: [
    GoRoute(path: AppRoutes.characters, builder: (context, state) => const CharacterListScreen()),
    GoRoute(
      path: AppRoutes.characterDetail,
      builder: (context, state) {
        final characterId = int.tryParse(state.uri.queryParameters['id'] ?? '') ?? 1;
        return CharacterDetailScreen(characterId: characterId);
      },
    ),
  ],
);
