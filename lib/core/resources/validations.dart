import 'validate.dart';

class Validations {
  static bool isValidUrl(String url) {
    final RegExp regex = RegExp(
      r'^(https?:\/\/)' // Must start with http:// or https://
      r'(([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}' // Domain name (e.g., example.com)
      r'|localhost' // Allow localhost
      r'|(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))' // OR IPv4 (e.g., 192.168.1.1)
      r'(:\d+)?(\/[^\s]*)?$', // Optional port and path
      caseSensitive: false,
    );

    return regex.hasMatch(url);
  }

  static bool isValidMobileNumber(String number) {
    final RegExp regex = RegExp(r'^\d{10,15}$');
    return regex.hasMatch(number);
  }

  static bool isValidIndianMobileNumber(String number) {
    final RegExp regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(number);
  }

  static bool isValidCountryNumber(String number) {
    final RegExp regex = RegExp(r'^\+?\d{10,15}$');
    return regex.hasMatch(number);
  }

  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final RegExp regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$',
    );
    return regex.hasMatch(password);
  }

  static Validate validatePassword(String password) {
    if (password.isEmpty) {
      return Validate(isValid: false, message: "Password is required");
    }
    if (password.length < 8 || password.length > 20) {
      return Validate(
        isValid: false,
        message: "Password must be 8-20 characters long",
      );
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return Validate(
        isValid: false,
        message: "Password must contain at least one uppercase letter",
      );
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return Validate(
        isValid: false,
        message: "Password must contain at least one lowercase letter",
      );
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return Validate(
        isValid: false,
        message: "Password must contain at least one number",
      );
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(password)) {
      return Validate(
        isValid: false,
        message:
            "Password must contain at least one special character (@, \$, !, etc.)",
      );
    }

    return Validate(isValid: true, message: "");
  }
}
