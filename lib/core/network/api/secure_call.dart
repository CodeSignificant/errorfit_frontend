import 'dart:convert';
import 'dart:typed_data';

import 'package:error_fit/config/routes/routers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../../../config/services/auth.dart';
import '../../resources/actions.dart';
import '../../resources/data_response.dart';
import 'api_sheet.dart';

class SecureCall {
  static bool _isRefreshing = false;

  static Map<String, String> getHeaders() => {
    'Authorization': 'Bearer ${Auth.token}',
    'Content-Type': 'application/json'
  };

  static Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    await _waitUntilRefresh();
    var res = await http.get(url, headers: headers ?? getHeaders());

    // final validRefreshToken =
    //     (res.headers['x-custom-http-status'] ?? 1004) == 1004;
    // trace("Headers ${res.headers['x-custom-http-status']}");
    if (res.statusCode == 401) { //&& validRefreshToken
      if ((await _refreshToken()) is DataFailed) {
        await Auth.logout;
        trace(url.toString());
        landingRoute.sweepNavigate;
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.get(url, headers: getHeaders());
    }

    return res;
  }

  static Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    await _waitUntilRefresh();
    Response res = await http.post(
      url,
      headers: headers ?? getHeaders(),
      body: body,
      encoding: encoding,
    );

    // final validRefreshToken =
    //     int.tryParse(res.headers['x-custom-http-status'] ?? '') == 1003;

    if (res.statusCode == 401) { // && validRefreshToken
      if (await _refreshToken() is DataFailed) {
        await Auth.logout;
        landingRoute.sweepNavigate;
        trace(url.toString());
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.post(
        url,
        headers: getHeaders(),
        body: body,
        encoding: encoding,
      );
    }
    return res;
  }

  static Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    await _waitUntilRefresh();
    Response res = await http.put(
      url,
      headers: headers ?? getHeaders(),
      body: body,
      encoding: encoding,
    );

    // final validRefreshToken =
    //     int.tryParse(res.headers['x-custom-http-status'] ?? '') == 1003;

    if (res.statusCode == 401) { // && validRefreshToken
      if (await _refreshToken() is DataFailed) {
        await Auth.logout;
        landingRoute.sweepNavigate;
        trace(url.toString());
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.put(
        url,
        headers: getHeaders(),
        body: body,
        encoding: encoding,
      );
    }
    return res;
  }

  static Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    await _waitUntilRefresh();
    var res = await http.delete(
      url,
      headers: headers ?? getHeaders(),
      body: body,
      encoding: encoding,
    );

    if (res.statusCode == 401) {
      if (await _refreshToken() is DataFailed) {
        await Auth.logout;
        landingRoute.sweepNavigate;
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.delete(
        url,
        headers: headers ?? getHeaders(),
        body: body,
        encoding: encoding,
      );
    }
    return res;
  }

//
// // Imports needed
//   import 'package:http/http.dart' as http;
//   import 'package:http_parser/http_parser.dart'; // Required for MediaType

  static Future<http.Response> uploadImage(Uri url,
      String keyName,
      Uint8List file, // ✅ Changed: Stronger typing instead of generic List<int>
      String fileName, {
        Map<String, String>? headers,
        Map<String, String>? body,
      }) async {
    await _waitUntilRefresh(); // ✅ Keeps flow paused until refresh is complete

    // ✅ Extracted request logic into function so we can reuse it after token refresh
    Future<http.Response> _send() async {
      final request = http.MultipartRequest('POST', url);

      // ✅ Added proper headers including optional ones
      request.headers.addAll({
        'Authorization': 'Bearer ${Auth.token}',
        if (headers != null) ...headers,
      });

      // ✅ Add optional form fields
      if (body != null) request.fields.addAll(body);

      // ✅ Added proper contentType using MediaType (required for server-side parsing)
      request.files.add(
        http.MultipartFile.fromBytes(
          keyName,
          file,
          filename: fileName,
          contentType: MediaType('image',
              'jpeg'), // ⚠️ You can use 'application/octet-stream' for generic files
        ),
      );

      // ✅ Convert streamed response into normal response
      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();
      return http.Response(responseString, streamedResponse.statusCode);
    }

    // ✅ First attempt
    http.Response response = await _send();

    // ✅ If 401, try to refresh token
    if (response.statusCode == 401) {
      final refreshResult = await _refreshToken();

      // ✅ If refresh failed, logout and navigate
      if (refreshResult is DataFailed) {
        await Auth.logout();
        landingRoute.sweepNavigate();
        await delay(milliSeconds: 1000);
        return http.Response("{}", 401);
      }

      // ✅ Retry upload with new token
      response = await _send();
    }

    return response;
  }


  static Future<DataResponse> _refreshToken() async {
    try {
      _isRefreshing = true;
      final res = await http.post(
        Uri.parse(ApiSheet.auth.refreshToken),
        headers: getHeaders(),
      );

      // final validRefreshToken =
      //     (res.headers['x-custom-http-status'] ?? 1004) == 1004;

      if (res.statusCode == 200) {
        final refreshRes = jsonDecode(res.body);
        if (refreshRes['status'] != "success") {
          return DataFailed(refreshRes['message']);
        }
        await Auth.setToken(refreshRes['data']['accessToken']);
        _isRefreshing = false;
        return const DataSuccess("Refresh Success");
      }
      Auth.logout;
      _isRefreshing = false;
      // loginRoute.sweepNavigate;
      return DataFailed("Server Error ${res.statusCode}");
    } catch (e) {
      return const DataFailed("Something went wrong");
    }
  }

  static Future<void> _waitUntilRefresh() async {
    while (_isRefreshing) {
      await delay(milliSeconds: 100);
    }
    return;
  }
}
