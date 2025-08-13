
import 'package:error_fit/config/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app_state.dart';

class PreLoaders {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await LocalStorage().init();
    // await AppState.init();
  }
}
