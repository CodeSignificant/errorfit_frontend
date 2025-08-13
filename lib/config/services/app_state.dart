import '../storage/local_storage.dart';

class AppState {
  static const _persistenceRoute = 'persistence_route';

  static final _storage = LocalStorage();

  static Future<void> setPersistenceRoute(String route) async {
    await _storage.setString(persistenceRoute, route);
  }

  static String get persistenceRoute {
    return _storage.getString(_persistenceRoute) ?? "";
  }


}
