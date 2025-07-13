import '../../../config/environments/config.dart';
class ApiSheet {
  static final auth = AuthApi();
}

class AuthApi {
  final String domain = Config.domain;
  final String _baseUrl = "${Config.baseUrl}/auth";

  String get refreshToken => "$_baseUrl/RefreshToken.php";

}

