import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../config/environments/config.dart';

String maskPhoneNumber(String phone) {
  if (phone.length <= 4) return phone;
  return phone.replaceRange(2, phone.length - 2, '*' * (phone.length - 4));
}

double get kStatusBarHeight => MediaQuery.of(Get.context!).viewPadding.top;

double get kBottomBarHeight => MediaQuery.of(Get.context!).viewPadding.bottom;



void trace(String message) {
  if (Config.isDev) {
    final traceString = StackTrace.current.toString().split('\n')[2];
    print('\n---------------\n$traceString\n$message\n========\n');
  }
}

openUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    trace("unable to launch url: $url");
  }
}

openBrowser(String url) async {
  if (url.isEmpty) return;
  if (!await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    return;
  }
  trace("unable to launch url: $url");
}

delay({int milliSeconds = 200}) async =>
    await Future.delayed(Duration(milliseconds: milliSeconds));

closeDialog(){
  if(Get.isBottomSheetOpen??false) Get.back();
  if(Get.isDialogOpen??false) Get.back();
}

Future<String> getUserAgent() async {
  // return "AurumApp";
  final deviceInfo = DeviceInfoPlugin();

  if (kIsWeb) {
    return "FlutterWeb";
  }

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return "Android ${androidInfo.model} / Android ${androidInfo.version.release}";
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return "iOS ${iosInfo.utsname.machine} / iOS ${iosInfo.systemVersion}";
  } else if (Platform.isLinux) {
    final linuxInfo = await deviceInfo.linuxInfo;
    return "Linux ${linuxInfo.prettyName}";
  } else if (Platform.isMacOS) {
    final macInfo = await deviceInfo.macOsInfo;
    return "macOS ${macInfo.model} / macOS ${macInfo.osRelease}";
  } else if (Platform.isWindows) {
    final windowsInfo = await deviceInfo.windowsInfo;
    return "Windows ${windowsInfo.computerName}";
  } else {
    return "Unknown Platform";
  }
}

Future<String> getAppVersion() async {
  final info = await PackageInfo.fromPlatform();
  return '${info.version}+${info.buildNumber}';
}

Future<String> getUniqueDeviceName() async {
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

Future<String> getDeviceOSVersion() async {
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