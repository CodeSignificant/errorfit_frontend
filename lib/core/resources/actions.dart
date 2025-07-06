import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
