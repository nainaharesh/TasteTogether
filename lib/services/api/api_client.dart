
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tastetogether/services/api/api_endpoints.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/api/api_headers.dart';
import 'package:tastetogether/services/api/token_storage.dart';

class ApiClient {
  static const Duration requestTimeout = Duration(seconds: 30);

  // Called when an authenticated request receives 401.
  static void Function()? onUnauthorized;

  // GET Request
  static Future<dynamic> get(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) {
    return sendRequest(
      'GET',
      path,
      query: query,
      auth: auth,
    );
  }

  // POST Request
  static Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) {
    return sendRequest(
      'POST',
      path,
      body: body,
      auth: auth,
    );
  }

  // PATCH Request
  static Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) {
    return sendRequest(
      'PATCH',
      path,
      body: body,
      auth: auth,
    );
  }

  // DELETE Request
  static Future<dynamic> delete(
    String path, {
    bool auth = true,
  }) {
    return sendRequest(
      'DELETE',
      path,
      auth: auth,
    );
  }

  // Main request handler
  static Future<dynamic> sendRequest(
    String method,
    String path, {
    Map<String, String>? query,
    Map<String, dynamic>? body,
    required bool auth,
  }) async {
    final uri = Uri.parse(
      '${ApiEndpoints.baseUrl}$path',
    ).replace(queryParameters: query);

    final headers = ApiHeaders.headerWithAndContentTypeJson(
      includeAuth: auth,
      token: auth ? TokenStorage.token : null,
    );

    final request = http.Request(method, uri)
      ..headers.addAll(headers);

    if (body != null) {
      request.body = jsonEncode(body);
    }

    try {
      final streamedResponse = await request
          .send()
          .timeout(requestTimeout);

      final response = await http.Response
          .fromStream(streamedResponse)
          .timeout(requestTimeout);

      return handleResponse(response, auth: auth);
    } on TimeoutException {
      throw ApiException(
        'Server response time out. Please try again.',
        isNetworkError: true,
      );
    } on http.ClientException {
      throw ApiException(
        'Internet connection error. Please check your connection.',
        isNetworkError: true,
      );
    }
  }

  // Response handling
  static dynamic handleResponse(
    http.Response response, {
    required bool auth,
  }) {
    final statusCode = response.statusCode;

    final responseBody = utf8.decode(
      response.bodyBytes,
      allowMalformed: true,
    );

    final data = responseBody.isEmpty
        ? null
        : decodeResponse(responseBody);

    if (statusCode >= 200 && statusCode < 300) {
      return data;
    }

    if (statusCode == 401 && auth) {
      onUnauthorized?.call();
    }

    throw ApiException(
      errorMessage(data, statusCode),
      statusCode: statusCode,
    );
  }

  // JSON decoding
  static dynamic decodeResponse(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  // Extract error message
  static String errorMessage(dynamic data, int statusCode) {
    final message = extractMessage(data);

    if (message != null && message.isNotEmpty) {
      return message;
    }

    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'Requested resource not found.';
      case 422:
        return 'Validation failed. Please check your input.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  // Extract message from API response
  static String? extractMessage(dynamic data) {
    if (data is! Map) return null;

    final error = data['error'];

    if (error is Map) {
      final message = error['message'];

      if (message is String) {
        return message;
      }
    }

    if (error is String) {
      return error;
    }

    final message = data['message'];

    if (message is String) {
      return message;
    }

    return null;
  }
}
