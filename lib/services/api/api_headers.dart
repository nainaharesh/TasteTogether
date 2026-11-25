// ignore_for_file: deprecated_member_use
class ApiHeaders {
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> build({String? token}) {
    return {
      ...defaultHeaders,
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
}
