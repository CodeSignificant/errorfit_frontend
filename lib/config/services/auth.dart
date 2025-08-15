import '../storage/local_storage.dart';

class Auth {
  static const _authTokenKey = 'auth_token';
  static const _userKey = 'user';

  static final _storage = LocalStorage();

  static Future<void> setToken(String token) async {
    await _storage.setString(_authTokenKey, token);
  }

  static String get token {
    return _storage.getString(_authTokenKey) ?? "";
  }

  static Future<void> setUser(
      {required String name, required String mail, required String countryCode,
        required String phone, required String gender}) async {
    await _storage.setEncryptedJson(_userKey, {
      "name": name,
      "mail": mail,
      "country_code": countryCode,
      "phone": phone,
      "gender": gender
    });
  }

  static String get name {
    Map<String, dynamic> userJson = _storage.getEncryptedJson(_userKey) ?? {};
    return userJson['name'] ?? "";
  }

  static String get mail {
    Map<String, dynamic> userJson = _storage.getEncryptedJson(_userKey) ?? {};
    return userJson['mail'] ?? "";
  }

  static String get countryCode {
    Map<String, dynamic> userJson = _storage.getEncryptedJson(_userKey) ?? {};
    return userJson['country_code'] ?? "";
  }

  static String get phone {
    Map<String, dynamic> userJson = _storage.getEncryptedJson(_userKey) ?? {};
    return userJson['phone'] ?? "";
  }

  static String get gender {
    Map<String, dynamic> userJson = _storage.getEncryptedJson(_userKey) ?? {};
    return userJson['gender'] ?? "";
  }

  static bool get isLogin {
    return (_storage.getString(_authTokenKey) ?? "").isNotEmpty;
  }


  static Future<void> clearAuth() async {
    await _storage.remove(_authTokenKey);
    await _storage.remove(_userKey);
  }

}
