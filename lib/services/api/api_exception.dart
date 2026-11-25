// ignore_for_file: deprecated_member_use
/// Har API error ek hi type mein: UI ko sirf message dikhana hota hai.
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.isNetworkError = false});

  final String message;
  final int? statusCode;

  /// Internet nahi / timeout (server tak request pahunchi hi nahi)
  final bool isNetworkError;

  bool get isUnauthorized => statusCode == 401;
  bool get isServerError => (statusCode ?? 0) >= 500;

  @override
  String toString() => message;
}
