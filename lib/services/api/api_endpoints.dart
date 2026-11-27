
class ApiEndpoints {
  static const String baseUrl =
      'https://tastetogether-backend.vercel.app';

  // Authentication
  static const String signup = '/api/auth/signup';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword =
      '/api/auth/forgot-password';
  static const String resetPassword =
      '/api/auth/reset-password';

 

  // My Profile
  static const String myProfile = '/api/users/me';

  // Other User Profile
  static String user(String otherUserId) =>
      '/api/users/$otherUserId';

  // Other User Reviews
  static String userReviews(String otherUserId) =>
      '/api/users/$otherUserId/reviews';

  // Other User Followers
  static String userFollowers(String otherUserId) =>
      '/api/users/$otherUserId/followers';

  // Other User Following
  static String userFollowing(String otherUserId) =>
      '/api/users/$otherUserId/following';

  // Follow Other User
  static String followUser(String otherUserId) =>
      '/api/users/$otherUserId/follow';


  // Unfollow Other User
  static String unfollowUser(String otherUserId) =>
      '/api/users/$otherUserId/follow';


  // Home and Explore
  static const String homeFeed = '/api/feed/home';
  static const String exploreFeed = '/api/feed/explore';

  // Restaurants
  static const String restaurants = '/api/restaurants';

  static String restaurant(String id) =>
      '/api/restaurants/$id';

  static String restaurantReviews(String id) =>
      '/api/restaurants/$id/reviews';

  static String restaurantDishes(String id) =>
      '/api/restaurants/$id/dishes';

  static String restaurantSave(String id) =>
      '/api/restaurants/$id/save';

  // Search and Saved
  static const String search = '/api/search';
  static const String saved = '/api/saved';
}
