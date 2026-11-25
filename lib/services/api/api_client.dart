// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:convert';

import 'package:tastetogether/services/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/api/api_headers.dart';
import 'package:tastetogether/services/token_storage.dart';

/// 4 methods of http e.g. get, post, patch, delete.
/// Token, headers, timeout and errors handle here

class ApiClient {
  // Vercel ka pehla (cold start) response slow ho sakta hai, is liye 30s
  static const requestTimeout = Duration(seconds: 30);

  /// Token expire / galat ho (401) to ye chalta hai.
  /// AuthController isay set karta hai: token hata kar Welcome par bhejta hai.
  static void Function()? onUnauthorized;

  static Future<dynamic> get(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) => sendRequest('GET', path, query: query, auth: auth);

  static Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) => sendRequest('POST', path, body: body, auth: auth);

  static Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) => sendRequest('PATCH', path, body: body, auth: auth);

  static Future<dynamic> delete(String path, {bool auth = true}) =>
      sendRequest('DELETE', path, auth: auth);

  // ---------------------------------------------------------------------------

  static Future<dynamic> sendRequest(
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
      final streamed = await request.send().timeout(requestTimeout);
      final response = await http.Response.fromStream(streamed);
      return handle(response, auth: auth);
    } on TimeoutException {
      throw ApiException(
        'Server jawab nahi de raha. Dobara try karein.',
        isNetworkError: true,
      );
    } on http.ClientException {
      throw ApiException(
        'Internet nahi hai. Connection check karein.',
        isNetworkError: true,
      );
    }
  }

  static dynamic handle(http.Response response, {required bool auth}) {
    final code = response.statusCode;
    // bodyBytes + utf8: Urdu / special characters kabhi kharab na hon
    final text = utf8.decode(response.bodyBytes, allowMalformed: true);
    final data = text.isEmpty ? null : decode(text);

    if (code >= 200 && code < 300) return data;

    // Login / signup (auth: false) par 401 ka matlab galat password hai,
    // "session khatam" nahi. Is liye callback sirf auth wali requests par.
    if (code == 401 && auth) onUnauthorized?.call();

    throw ApiException(errorMessage(data, code), statusCode: code);
  }

  static dynamic decode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  /// Server ka message pehle (error / message / errors), warna status code se.
  static String errorMessage(dynamic data, int code) {
    final fromServer = extractMessage(data);
    if (fromServer != null && fromServer.trim().isNotEmpty) return fromServer;

    if (code == 400 || code == 422) return 'Di gayi maloomat check karein.';
    if (code == 401) return 'Email ya password galat hai.';
    if (code == 403) return 'Aapko is ki ijazat nahi.';
    if (code == 404) return 'Ye cheez nahi mili.';
    if (code == 409) return 'Ye pehle se maujood hai.';
    if (code == 429) return 'Bohat zyada koshishein. Thori dair baad try karein.';
    if (code >= 500) return 'Server mein masla hai. Thori dair baad try karein.';
    return 'Kuch galat ho gaya ($code). Dobara try karein.';
  }

  /// Backend kabhi {error: "..."}, kabhi {message: "..."}, kabhi list / map
  /// bhejta hai. Sab mein se pehla samajh aane wala text nikalta hai.
  static String? extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    if (data is List) {
      final parts = data.map(extractMessage).whereType<String>().toList();
      return parts.isEmpty ? null : parts.join('\n');
    }
    if (data is Map) {
      for (final key in ['error', 'message', 'errors', 'detail']) {
        final found = extractMessage(data[key]);
        if (found != null && found.trim().isNotEmpty) return found;
      }
    }
    return null;
  }
}