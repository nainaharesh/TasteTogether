
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final bool isNetworkError;

  ApiException(
    this.message, {
    this.statusCode,
    this.isNetworkError = false,
  });

  bool get isUnauthorized => statusCode == 401;

  bool get isServerError => (statusCode ?? 0) >= 500;

  @override
  String toString() => message;
}
