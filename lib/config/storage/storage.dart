import 'package:shared_preferences/shared_preferences.dart';
import 'storage_room.dart';

class Storage {
  static late SharedPreferences _prefs;
  static final Map<String, StorageRoom> _rooms = {};

  /// Call once at app start
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Create or get existing room
  static StorageRoom room(String name) {
    return _rooms.putIfAbsent(name, () => StorageRoom(name, _prefs));
  }

  /// Define rooms with clean access here
  static StorageRoom get auth => room('auth');
  static StorageRoom get user => room('user');
  static StorageRoom get settings => room('settings');

// Add more as needed...
}
