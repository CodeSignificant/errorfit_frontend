import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  static SharedPreferences? _instance;

  static const _socialMediaLinks = "social_media_links";

  // Initialize SharedPreferences once
  static Future<void> init() async {
    _instance ??= await SharedPreferences.getInstance();
  }

  // Getter for SharedPreferences instance (throws error if not initialized)
  static SharedPreferences get getInstance {
    if (_instance == null) {
      throw Exception(
          "SharedPreferences has not been initialized. Call AppState.init() first.");
    }
    return _instance!;
  }

  // Getter for checking if landing pages were seen

  static String get facebookLink {
    return jsonDecode(
            _instance?.getString(_socialMediaLinks) ?? "{}")['facebook'] ??
        "/contact-us";
  }

  static String get instagramLink {
    return jsonDecode(
            _instance?.getString(_socialMediaLinks) ?? "{}")['instagram'] ??
        "/contact-us";
  }

  // Setter for marking landing pages as seen
  static setSocialMediaLinks(dynamic links) {
    _instance?.setString(_socialMediaLinks, links.toString());
  }
}
