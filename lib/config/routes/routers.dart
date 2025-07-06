import 'package:get/get.dart';

import '../../core/resources/basic_enc.dart';

// ---------------------------------------------------------------------------- LAUNCH
GenerateRoute get landingRoute => GenerateRoute("/landing");

GenerateRoute get homeRoute => GenerateRoute("/home");



// ---------------------------------------------------------------------------- AUTH

// GenerateRoute get loginRoute => GenerateRoute("/login");
//
// GenerateRoute get registerRoute => GenerateRoute("/register");

// ---------------------------------------------------------------------------- TEST
GenerateRoute get testRoute => GenerateRoute("/test");

GenerateRoute get notFoundRoute => GenerateRoute("/not_found");

navigate(String? route) {
  if (route != null) {
    Get.toNamed(route);
    return;
  }
}

// bool redirect() {
//   if (Auth.redirect.isNotEmpty) {
//     navigate(Auth.redirect);
//     Auth.setRedirect("");
//     return true;
//   }
//   return false;
// }

class GenerateRoute {
  String route;

  GenerateRoute(this.route);

  GenerateRoute param(String param) {
    route += "/$param";
    return this;
  }
  GenerateRoute queryParam(String name, String value) {
    if (route.contains('?')) {
      route += '&$name=$value';
    } else {
      route += '?$name=$value';
    }
    return this;
  }

  GenerateRoute encParam(String param) {
    route += "/${BasicEnc.encode(param)}";
    return this;
  }

  GenerateRoute key(String param) {
    route += "/:$param";
    return this;
  }

  get navigate {
    Get.toNamed(route);
  }

  void push(dynamic arguments) {
    Get.toNamed(route, arguments: arguments);
  }

  get replace {
    Get.offNamed(route);
  }

  get sweepNavigate {
    Get.offAllNamed(route);
  }

  void until(String untilRoute) {
    Get.offNamedUntil(route, (route) => route.settings.name == untilRoute);
  }
}
