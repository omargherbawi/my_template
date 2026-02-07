abstract class AppRoutes {
  AppRoutes._();


  static const characters = "/characters";
  static const characterDetail = "/character-detail";
  static String characterDetailPath(int id) => "/character-detail/$id";


}
