import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../enums/flavours.dart';

class Config {
  static Flavours _flavour = Flavours.dev;

  static init(Flavours flavour) async {
    switch (flavour) {
      case Flavours.pro:
        _flavour = Flavours.pro;
        return await dotenv.load(
            fileName: "lib/config/environments/.env.pro.dart");
      default:
        _flavour = Flavours.dev;
        return await dotenv.load(
            fileName: "lib/config/environments/.env.dev.dart");
    }
  }

  static bool get isDev => _flavour == Flavours.dev;
  static bool get isPro => _flavour == Flavours.pro;

  static String get appName {
    return dotenv.env['APP_NAME'] ?? "CS";
  }

  static String get razorpayKey {
    return dotenv.env['RAZORPAY_KEY'] ?? "";
  }

  static String get mail {
    return dotenv.env['CONTACT_MAIL'] ?? "";
  }

  static String get phone {
    return dotenv.env['CONTACT_PHONE'] ?? "";
  }

  static String get domain {
    return dotenv.env['DOMAIN'] ?? "codesignificant.com";
  }

  static String get webSiteBase {
    return dotenv.env['WEBSITE_BASE'] ?? "https://codesignificant.com";
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? "https://codesignificant.com";
  }

  static String get imageBaseUrl {
    return dotenv.env['IMAGE_BASE_URL'] ?? "https://codesignificant.com/storage";
  }

  // static String get contactMail {
  //   return dotenv.env['CONTACT_MAIL'] ?? "";
  // }
  // static String get contactPhone {
  //   return dotenv.env['CONTACT_PHONE'] ?? "";
  // }
}
