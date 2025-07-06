import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../core/resources/actions.dart';
import 'app_state.dart';

class Auth {
  static late final SharedPreferences _instance;
  static const _token = "token";
  static const _name = "name";
  static const _mail = "mail";
  static const _phone = "phone";
  static const _persistenceRoute = "persistence_route";
  static const _appId = "app_id";

  static Future<SharedPreferences> init() async {
    _instance = AppState.getInstance;
    return _instance;
  }

  static Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return '${info.version}+${info.buildNumber}';
  }

  static Future<String> getUniqueDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      final info = await deviceInfo.webBrowserInfo;
      final deviceName =
          '${info.browserName.name}_${info.userAgent}_${info.hardwareConcurrency}';
      return deviceName;
    } else if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return '${info.model}_${info.id}';
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return '${info.name}_${info.identifierForVendor}';
    } else {
      return 'UnknownDevice_${const Uuid().v4()}';
    }
  }

  static Future<String> getDeviceOSVersion() async {
    final deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      final info = await deviceInfo.webBrowserInfo;
      return '${info.platform} - ${info.userAgent}';
    } else if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return 'Android ${info.version.release} (SDK ${info.version.sdkInt})';
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return '${info.systemName} ${info.systemVersion}';
    } else if (Platform.isWindows) {
      final info = await deviceInfo.windowsInfo;
      return 'Windows ${info.displayVersion} (Build ${info.buildNumber})';
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return 'macOS ${info.osRelease}';
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return 'Linux ${info.version}';
    } else {
      return 'Unknown OS';
    }
  }

  static bool get isLogin => (_instance.getString(_token) ?? "").isNotEmpty;

  static String get token => _instance.getString(_token) ?? "";


  static String get name => _instance.getString(_name) ?? "";


  static String get mail => _instance.getString(_mail) ?? "";

  static String get phone => _instance.getString(_phone) ?? "";


  static String get persistenceRoute =>
      _instance.getString(_persistenceRoute) ?? "";

  static int get appId => _instance.getInt(_appId) ?? 0;



  static setUser({
    required String mail,
    required String phone,
    required String name,
  }) {
    _instance.setString(_name, name);
    _instance.setString(_mail, mail);
    _instance.setString(_phone, phone);
  }



  static setToken(String token) => _instance.setString(_token, token);


  static setName(String name) => _instance.setString(_name, name);

  static setMail(String mail) => _instance.setString(_mail, mail);

  static setPhone(String phone) => _instance.setString(_phone, phone);

  static setPersistenceRoute(String route) =>
      _instance.setString(_persistenceRoute, route);


  static setAppId(int appId){
    _instance.setInt(_appId, appId);
  }

  static get logout async {
    _instance.clear();
  }
}
