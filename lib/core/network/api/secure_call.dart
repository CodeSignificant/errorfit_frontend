import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'package:error_fit/config/routes/routers.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../config/services/auth.dart';
import '../../resources/actions.dart';
import '../../resources/data_response.dart';
import 'api_sheet.dart';

class SecureCall {
  // ------------------------------
  // Private class-level variables
  // ------------------------------
  static bool _isRefreshing = false;
  static const int _maxRetries = 2;
  static const Duration _retryDelay = Duration(seconds: 1);

  static Map<String, String> get getHeaders => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Auth.token}',
  };

  // ------------------------------
  // Core helper: 401 handling + retry on 5xx
  // ------------------------------
  static Future<http.Response> _withRefresh(Future<http.Response> Function() request) async {
    await _waitUntilRefresh();

    int attempt = 0;
    http.Response response;

    do {
      response = await request();

      // Handle 401 / refresh token
      if (response.statusCode == 401) {
        final refreshResult = await _refreshToken();
        if (refreshResult is DataFailed) {
          await Auth.clearAuth();
          landingRoute.sweepNavigate();
          await delay(milliSeconds: 1000);
          return http.Response("{}", 401);
        }
        response = await request();
      }

      // Retry if server error 5xx
      if (response.statusCode >= 500 && response.statusCode < 600) {
        attempt++;
        if (attempt < _maxRetries) await Future.delayed(_retryDelay);
      } else {
        break;
      }
    } while (attempt < _maxRetries);

    return response;
  }

  // ------------------------------
  // Generic try* helper
  // ------------------------------
  static Future<DataResponse<T>> _tryRequest<T>(
      Future<http.Response> Function() request,
      Future<DataResponse<T>> Function(http.Response response, dynamic data) onSuccess,
      ) async {
    try {
      final response = await request();

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DataFailed("Server Error (${response.statusCode})") as DataResponse<T>;
      }

      final decoded = jsonDecode(response.body);

      // API-level status check (if `status` exists)
      if (decoded is Map<String, dynamic> &&
          decoded.containsKey('status') &&
          decoded['status'] is bool &&
          decoded['status'] == false) {
        trace(response.body);
        return DataFailed(decoded['message'] ?? "Request failed") as DataResponse<T>;
      }

      return await onSuccess(response, decoded);
    } catch (e, s) {
      trace(e.toString());
      trace(s.toString());
      return const DataFailed("Something went wrong") as DataResponse<T>;
    }
  }

  // ------------------------------
  // HTTP methods using _withRefresh
  // ------------------------------
  static Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
      _withRefresh(() => http.get(url, headers: headers ?? getHeaders));

  static Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withRefresh(
              () => http.post(url, headers: headers ?? getHeaders, body: body, encoding: encoding));

  static Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withRefresh(
              () => http.put(url, headers: headers ?? getHeaders, body: body, encoding: encoding));

  static Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      _withRefresh(
              () => http.delete(url, headers: headers ?? getHeaders, body: body, encoding: encoding));

  static Future<http.Response> uploadImage(
      Uri url,
      String keyName,
      Uint8List file,
      String fileName, {
        Map<String, String>? headers,
        Map<String, String>? body,
        String mimeType = 'jpeg',
      }) =>
      _withRefresh(() async {
        final request = http.MultipartRequest('POST', url);
        request.headers.addAll({
          'Authorization': 'Bearer ${Auth.token}',
          if (headers != null) ...headers,
        });
        if (body != null) request.fields.addAll(body);
        request.files.add(http.MultipartFile.fromBytes(
          keyName,
          file,
          filename: fileName,
          contentType: MediaType('image', mimeType),
        ));

        final streamedResponse = await request.send();
        final responseString = await streamedResponse.stream.bytesToString();
        return http.Response(responseString, streamedResponse.statusCode);
      });

  // ------------------------------
  // Generic try* methods
  // ------------------------------
  static Future<DataResponse<T>> tryGet<T>(
      Uri url, {
        Map<String, String>? headers,
        required Future<DataResponse<T>> Function(http.Response response, dynamic data) onSuccess,
      }) =>
      _tryRequest(() => get(url, headers: headers), onSuccess);

  static Future<DataResponse<T>> tryPost<T>(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        required Future<DataResponse<T>> Function(http.Response response, dynamic data) onSuccess,
      }) =>
      _tryRequest(() => post(url, headers: headers, body: body, encoding: encoding), onSuccess);

  static Future<DataResponse<T>> tryPut<T>(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        required Future<DataResponse<T>> Function(http.Response response, dynamic data) onSuccess,
      }) =>
      _tryRequest(() => put(url, headers: headers, body: body, encoding: encoding), onSuccess);

  static Future<DataResponse<T>> tryDelete<T>(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
        Encoding? encoding,
        required Future<DataResponse<T>> Function(http.Response response, dynamic data) onSuccess,
      }) =>
      _tryRequest(() => delete(url, headers: headers, body: body, encoding: encoding), onSuccess);

  static Future<DataResponse<T>> tryUploadImage<T>(
      Uri url,
      String keyName,
      Uint8List file,
      String fileName, {
        Map<String, String>? headers,
        Map<String, String>? body,
        String mimeType = 'jpeg',
        required Future<DataResponse<T>> Function(http.Response response, dynamic data) onSuccess,
      }) =>
      _tryRequest(
              () => uploadImage(url, keyName, file, fileName,
              headers: headers, body: body, mimeType: mimeType),
          onSuccess);

  // ------------------------------
  // Refresh token logic
  // ------------------------------
  static Future<DataResponse> _refreshToken() async {
    try {
      _isRefreshing = true;
      final res = await http.get(Uri.parse(ApiSheet.auth.refreshToken), headers: getHeaders);

      if (res.statusCode == 200) {
        final refreshRes = jsonDecode(res.body);
        if (!refreshRes['status']) {
          _isRefreshing = false;
          return DataFailed(refreshRes['message']);
        }
        await Auth.setToken(refreshRes['token']);
        _isRefreshing = false;
        return const DataSuccess("Refresh Success");
      }

      _isRefreshing = false;
      Auth.clearAuth();
      landingRoute.sweepNavigate;
      await delay(milliSeconds: 1000);
      return DataFailed("Server Error ${res.statusCode}");
    } catch (e) {
      _isRefreshing = false;
      return const DataFailed("Something went wrong");
    }
  }

  static Future<void> _waitUntilRefresh() async {
    while (_isRefreshing) {
      await delay(milliSeconds: 100);
    }
  }
}
