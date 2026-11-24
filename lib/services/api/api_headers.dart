class ApiHeaders {
  ApiHeaders._();

  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  static Map<String, String> build({String? token}) {
    return {
      ..._defaultHeaders,
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
}
