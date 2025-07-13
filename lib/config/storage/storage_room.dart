import 'package:shared_preferences/shared_preferences.dart';

class StorageRoom {
  final String prefix;
  final SharedPreferences prefs;

  StorageRoom(this.prefix, this.prefs);

  /// Full key format: prefix_key
  String _key(String key) => '${prefix}_$key';

  // --- Token Example ---
  Future<void> setToken(String value) async =>
      await prefs.setString(_key('token'), value);

  String? get token => prefs.getString(_key('token'));

  void createToken<T>() {
    final key = _key('token');
    if (!prefs.containsKey(key)) {
      if (T == String) prefs.setString(key, '');
      if (T == int) prefs.setInt(key, 0);
      if (T == bool) prefs.setBool(key, false);
      if (T == double) prefs.setDouble(key, 0.0);
      if (T == List<String>) prefs.setStringList(key, []);
    }
  }

  // --- Add More Data Accessors Below ---

  Future<void> setUserId(String value) async =>
      await prefs.setString(_key('userId'), value);

  String? get userId => prefs.getString(_key('userId'));

  Future<void> clearAll() async {
    final keys = prefs.getKeys(); // ✅ correct method
    final keysToRemove = keys.where((k) => k.startsWith('${prefix}_'));

    for (final key in keysToRemove) {
      await prefs.remove(key);
    }
  }

}
