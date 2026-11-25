// ignore_for_file: deprecated_member_use
class ApiEndpoints {
  static const String baseUrl = 'https://tastetogether-backend.vercel.app';

  // Authentication endpoints
  static const String signup = '/api/auth/signup';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';

  // later on User
  static const String myProfile = '/api/users/me';

  // Feed endpoints
  static const String homeFeed = '/api/feed/home'; // ?tab=&page=&limit=
  static const String exploreFeed = '/api/feed/explore';

  // Restaurant endpoints
  static const String restaurants = '/api/restaurants'; // list: ?cuisine=&sort=&page=&limit=
  static String restaurant(String id) => '/api/restaurants/$id';
  static String restaurantReviews(String id) => '/api/restaurants/$id/reviews';
  static String restaurantDishes(String id) => '/api/restaurants/$id/dishes';
  static String restaurantSave(String id) => '/api/restaurants/$id/save'; // POST save, DELETE unsave

  // Search
  static const String search = '/api/search'; // ?q=&type=&sort=

  // Saved
  static const String saved = '/api/saved'; // ?type=all&page=&limit=
}
