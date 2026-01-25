
import '../../global_imports.dart';

class HiveServices {
  Future<void> init() async {
    // appBox is already initialized in main.dart
    // Only initialize other boxes here
    await Future.wait([
    ]);
  }


  Future<void> _initAppBox() async {
    await Hive.openBox(BoxKey.appBox);
  }



  Future<void> _initializeBoxModel<T>({required String boxName}) async {
    try {
      final Box<T> box = await Hive.openBox<T>(boxName);
      if (!getIt.isRegistered<Box<T>>()) {
        getIt.registerSingleton<Box<T>>(box);
      }
    } on Exception catch (e) {
      logger.e('Error while opening box $boxName : $e');
    }
  }
}
