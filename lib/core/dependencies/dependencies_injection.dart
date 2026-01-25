import '../../../../global_imports.dart';
import '../../feature/character/di/character_di.dart';

final getIt = GetIt.instance;

void initGetIt() async {
  //======================== Dio ===============================================
  getIt.registerSingleton<AppServices>(AppServices());
  // appBox is already registered in main.dart during initialization
  
  //======================== Services ==========================================
  getIt.registerLazySingleton<HeadersProvider>(
        () => HeadersProvider(hive: getIt<Box>(instanceName: BoxKey.appBox)),
  );
  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  getIt.registerLazySingleton(() => ConnectionCubit(getIt<NetworkInfo>()));

  //======================== Hive Boxes ========================================

  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  getIt.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(aOptions: getAndroidOptions()),
  );

  //======================== Features  =========================================

  initCharacterDI();
}
