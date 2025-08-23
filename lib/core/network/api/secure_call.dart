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

  static Map<String, String> get getHeaders =>
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Auth.token}'
  };

  static Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    await _waitUntilRefresh();
    var res = await http.get(url, headers: headers ?? getHeaders);
    if (res.statusCode == 401) { //&& validRefreshToken
      if ((await _refreshToken()) is DataFailed) {
        await Auth.clearAuth();
        landingRoute.sweepNavigate;
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.get(url, headers: getHeaders);
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
      headers: headers ?? getHeaders,
      body: body,
      encoding: encoding,
    );

    if (res.statusCode == 401) {
      if (await _refreshToken() is DataFailed) {
        await Auth.clearAuth();
        landingRoute.sweepNavigate;
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.post(
        url,
        headers: getHeaders,
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
      headers: headers ?? getHeaders,
      body: body,
      encoding: encoding,
    );

    if (res.statusCode == 401) { // && validRefreshToken
      if (await _refreshToken() is DataFailed) {
        await Auth.clearAuth();
        landingRoute.sweepNavigate;
        trace(url.toString());
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.put(
        url,
        headers: getHeaders,
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
      headers: headers ?? getHeaders,
      body: body,
      encoding: encoding,
    );

    if (res.statusCode == 401) {
      if (await _refreshToken() is DataFailed) {
        await Auth.clearAuth();
        landingRoute.sweepNavigate;
        await delay(milliSeconds: 1000);
        return Response("{}", 401);
      }
      res = await http.delete(
        url,
        headers: headers ?? getHeaders,
        body: body,
        encoding: encoding,
      );
    }
    return res;
  }

  static Future<http.Response> uploadImage(Uri url,
      String keyName,
      Uint8List file,
      String fileName, {
        Map<String, String>? headers,
        Map<String, String>? body,
      }) async {
    await _waitUntilRefresh();

    Future<http.Response> send() async {
      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer ${Auth.token}',
        if (headers != null) ...headers,
      });

      if (body != null) request.fields.addAll(body);

      request.files.add(
        http.MultipartFile.fromBytes(
          keyName,
          file,
          filename: fileName,
          contentType: MediaType('image',
              'jpeg'),
        ),
      );

      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();
      return http.Response(responseString, streamedResponse.statusCode);
    }

    http.Response response = await send();

    if (response.statusCode == 401) {
      final refreshResult = await _refreshToken();

      if (refreshResult is DataFailed) {
        await Auth.clearAuth();
        landingRoute.sweepNavigate();
        await delay(milliSeconds: 1000);
        return http.Response("{}", 401);
      }
      response = await send();
    }

    return response;
  }


  static Future<DataResponse> _refreshToken() async {
    try {
      _isRefreshing = true;
      final res = await http.get(
        Uri.parse(ApiSheet.auth.refreshToken),
        headers: getHeaders,
      );

      if (res.statusCode == 200) {
        final refreshRes = jsonDecode(res.body);
        if (!refreshRes['status']) {
          return DataFailed(refreshRes['message']);
        }
        await Auth.setToken(refreshRes['token']);
        _isRefreshing = false;
        return const DataSuccess("Refresh Success");
      }
      Auth.clearAuth();
      _isRefreshing = false;
      landingRoute.sweepNavigate;
      await delay(milliSeconds: 1000);
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
