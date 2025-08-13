import 'dart:convert';

import 'package:error_fit/core/resources/actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/resources/encryption_helper.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  SharedPreferences? _prefs;

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) => _prefs?.getString(key);

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  int? getInt(String key) => _prefs?.getInt(key);

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) => _prefs?.getBool(key);

  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  double? getDouble(String key) => _prefs?.getDouble(key);

  Future<void> setStringList(String key, List<String> value) async {
    await _prefs?.setStringList(key, value);
  }

  List<String>? getStringList(String key) => _prefs?.getStringList(key);

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await _prefs?.setString(key, jsonString);
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs?.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString);
    } catch (_) {
      return null;
    }
  }

  Future<void> setEncryptedString(String key, String value) async {
    final encrypted = EncryptionHelper.encrypt(value);
    await _prefs?.setString(key, encrypted);
  }

  String? getEncryptedString(String key) {
    final encrypted = _prefs?.getString(key);
    if (encrypted == null) return null;
    return EncryptionHelper.decrypt(encrypted);
  }

  Future<void> setEncryptedJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    final encrypted = EncryptionHelper.encrypt(jsonString);
    await _prefs?.setString(key, encrypted);
  }

  Map<String, dynamic>? getEncryptedJson(String key) {
    final encrypted = _prefs?.getString(key);
    if (encrypted == null) return null;
    try {
      final decrypted = EncryptionHelper.decrypt(encrypted);
      return jsonDecode(decrypted);
    } catch (_) {
      return null;
    }
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
