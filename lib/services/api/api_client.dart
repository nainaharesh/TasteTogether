import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tastetogether/services/api/api_endpoints.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/api/api_headers.dart';
import 'package:tastetogether/services/token_storage.dart';

/// 4 methods of http e.g. get, post, patch, delete.
/// Token, headers, timeout and errors handle here

class ApiClient {
  ApiClient._();

  static const _timeout = Duration(seconds: 20);

  /// Token expire / galat ho (401) to ye chalta hai.
  /// AuthController isay set karta hai: token hata kar Welcome par bhejta hai.
  static void Function()? onUnauthorized;

  static Future<dynamic> get(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) => _send('GET', path, query: query, auth: auth);

  static Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) => _send('POST', path, body: body, auth: auth);

  static Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) => _send('PATCH', path, body: body, auth: auth);

  static Future<dynamic> delete(String path, {bool auth = true}) =>
      _send('DELETE', path, auth: auth);

  // ---------------------------------------------------------------------------

  static Future<dynamic> _send(
    String method,
    String path, {
    Map<String, String>? query,
    Map<String, dynamic>? body,
    required bool auth,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$path')
        .replace(queryParameters: query);

    final request = http.Request(method, uri)
      ..headers.addAll(
        ApiHeaders.build(token: auth ? TokenStorage.token : null),
      );
    if (body != null) request.body = jsonEncode(body);

    try {
      final streamed = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamed);
      return _handle(response, auth: auth);
    } on TimeoutException {
      throw ApiException('Server jawab nahi de raha. Dobara try karein.');
    } on http.ClientException {
      throw ApiException('Internet nahi hai. Connection check karein.');
    }
  }

  static dynamic _handle(http.Response response, {required bool auth}) {
    final code = response.statusCode;
    final data = response.body.isEmpty ? null : _decode(response.body);

    if (code >= 200 && code < 300) return data;

    // Login / signup (auth: false) par 401 ka matlab galat password hai,
    // "session khatam" nahi. Is liye callback sirf auth wali requests par.
    if (code == 401 && auth) onUnauthorized?.call();

    throw ApiException(_errorMessage(data, code), statusCode: code);
  }

  static dynamic _decode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  static String _errorMessage(dynamic data, int code) {
    if (data is Map) {
      final message = data['error'] ?? data['message'];
      if (message != null) return message.toString();
    }
    return 'something went wrong ($code). try again.';
  }
}
