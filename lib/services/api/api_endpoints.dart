class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://tastetogether-backend.vercel.app';

  // Authentication endpoints
  static const String signup = '/api/auth/signup';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';

  // later on User
  static const String myProfile = '/api/users/me';
 
}
