
import 'package:error_fit/config/storage/local_storage.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_strategy/url_strategy.dart';


class PreLoaders {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform
      );
    } catch (e) {
      trace("$e");
    }
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await LocalStorage().init();
    // await AppState.init();
  }
}
