
import 'package:tastetogether/services/api/token_storage.dart';

class ApiHeaders {
  // Headers without authentication
  static Map<String, String> headerWithContentTypeJsonOnly() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // Headers with optional Bearer token
  static Map<String, String> headerWithAndContentTypeJson({
    bool includeAuth = true,
    String? token,
  }) {
    final headers = headerWithContentTypeJsonOnly();

    if (includeAuth) {
      final savedToken = token ?? TokenStorage.token;

      if (savedToken != null && savedToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $savedToken';
      }
    }

    return headers;
  }

  // General header builder used by ApiClient
  static Map<String, String> build({String? token}) {
    return headerWithAndContentTypeJson(
      includeAuth: token != null,
      token: token,
    );
  }
}
