
import '../storage/local_storage.dart';

class HomeFlowStorage {
  static const _appInfo = 'app_info';
  static const _mobile = 'mobile';
  static const _tab = 'tab';
  static const _web = 'web';

  static final _storage = LocalStorage();

  static Future<void> setAppInfoJson(Map<String, dynamic> json) async {
    await _storage.setJson(_appInfo, json);
  }

  static Map<String, dynamic> get appInfoJson {
    return _storage.getJson(_appInfo) ?? {};
  }

  static Future<void> setMobileJson(Map<String, dynamic> json) async {
    await _storage.setJson(_mobile, json);
  }

  static Map<String, dynamic> get mobileJson {
    return _storage.getJson(_mobile) ?? {};
  }

  static Future<void> setTabJson(Map<String, dynamic> json) async {
    await _storage.setJson(_tab, json);
  }

  static Map<String, dynamic> get tabJson {
    return _storage.getJson(_tab) ?? {};
  }

  static Future<void> setWebJson(Map<String, dynamic> json) async {
    await _storage.setJson(_web, json);
  }

  static Map<String, dynamic> get webJson {
    return _storage.getJson(_web) ?? {};
  }

  static Future<void> clearAuth() async {
    await _storage.remove(_mobile);
    await _storage.remove(_tab);
    await _storage.remove(_web);
    await _storage.remove(_appInfo);
  }
}
