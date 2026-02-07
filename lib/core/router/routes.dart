import '../../../../global_imports.dart';
import '../../features/character/presentation/cubit/character_detail_cubit.dart';
import '../../features/character/presentation/screens/all_character_screen.dart';
import '../../features/character/presentation/screens/character_details_screen.dart';

GoRouter goRouters = GoRouter(
  navigatorKey: GlobalContext.navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.characters,
  routes: [
    GoRoute(
      path: AppRoutes.characters,
      builder: (context, state) => const AllCharacterScreen(),
    ),
    GoRoute(
      path: '/character-detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (context) => getIt <CharacterDetailCubit>()..getCharacterById(id),
          child: const CharacterDetailsScreen(),
        );
      },
    ),
  ],
);
