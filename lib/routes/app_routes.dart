import 'package:get/get.dart';

import '../models/dish_model.dart';
import '../models/post_models.dart';
import '../models/profile_model.dart';
import '../models/resturant_model.dart';
import '../models/review_model.dart';
import '../models/search_filters_model.dart';

import '../viewmodels/auth/auth_controller.dart';

import '../views/splashscreen.dart';
import '../views/authentication/forgetpasswordscreen.dart';
import '../views/authentication/login_view.dart';
import '../views/authentication/signupscreen.dart';
import '../views/authentication/welcomescreen.dart';

import '../views/main_application/all_dishes.dart';
import '../views/main_application/all_reviews.dart';
import '../views/main_application/bottom_navbar.dart';
import '../views/main_application/comments.dart';
import '../views/main_application/create_review.dart';
import '../views/main_application/dish_details.dart';
import '../views/main_application/resturant_details.dart';
import '../views/main_application/search_results.dart';

import '../views/user_activity/followers.dart';
import '../views/user_activity/notifications.dart';
import '../views/user_activity/public_profile.dart';

import '../views/profile_screen/edit_profile_screen.dart';
import '../views/profile_screen/help_support_screen.dart';

class AppRoutes {
  AppRoutes._();

  // Authentication
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main application
  static const String home = '/home';
  static const String searchResults = '/search-results';
  static const String restaurantDetails = '/restaurant-details';
  static const String dishDetails = '/dish-details';
  static const String comments = '/comments';
  static const String createReview = '/create-review';
  static const String allReviews = '/all-reviews';
  static const String allDishes = '/all-dishes';

  // User activity
  static const String notifications = '/notifications';
  static const String followers = '/followers';
  static const String publicProfile = '/public-profile';

  // Profile
  static const String editProfile = '/edit-profile';
  static const String help = '/help';
}

class SearchArgs {
  const SearchArgs({
    this.query = '',
    this.initialFilter = 0,
    this.filters = const SearchFilters(),
  });

  final String query;
  final int initialFilter;
  final SearchFilters filters;
}

class ReviewArgs {
  const ReviewArgs({this.restaurantName, this.dishName});

  final String? restaurantName;
  final String? dishName;
}

class AllReviewsArgs {
  const AllReviewsArgs({required this.title, required this.reviews});

  final String title;
  final List<Review> reviews;
}

class AllDishesArgs {
  const AllDishesArgs({required this.restaurantName, required this.dishes});

  final String restaurantName;
  final List<Dish> dishes;
}

class FollowersArgs {
  const FollowersArgs({required this.profile, this.initialTab = 0});

  final UserProfile profile;
  final int initialTab;
}

class AppPages {
  AppPages._();

  // Auth controller remains alive across authentication screens.
  static final initialBinding = BindingsBuilder(() {
    Get.put<AuthController>(AuthController(), permanent: true);
  });

  static final List<GetPage> pages = [
    // Authentication
    GetPage(name: AppRoutes.splash, page: () => const Splashscreen()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),

    // Main application
    GetPage(name: AppRoutes.home, page: () => BottomNavbarScreen()),
    GetPage(
      name: AppRoutes.searchResults,
      page: () {
        final args = Get.arguments as SearchArgs? ?? const SearchArgs();
        return SearchResults(
          query: args.query,
          initialFilter: args.initialFilter,
          filters: args.filters,
        );
      },
    ),
    GetPage(
      name: AppRoutes.restaurantDetails,
      page: () => ResturantDetails(restaurant: Get.arguments as Restaurant),
    ),
    GetPage(
      name: AppRoutes.dishDetails,
      page: () => DishDetails(dish: Get.arguments as Dish),
    ),
    GetPage(
      name: AppRoutes.comments,
      page: () => Comments(post: Get.arguments as Post),
    ),
    GetPage(
      name: AppRoutes.createReview,
      page: () {
        final args = Get.arguments as ReviewArgs? ?? const ReviewArgs();
        return CreateReview(
          restaurantName: args.restaurantName,
          dishName: args.dishName,
        );
      },
    ),
    GetPage(
      name: AppRoutes.allReviews,
      page: () {
        final args = Get.arguments as AllReviewsArgs;
        return AllReviews(title: args.title, reviews: args.reviews);
      },
    ),
    GetPage(
      name: AppRoutes.allDishes,
      page: () {
        final args = Get.arguments as AllDishesArgs;
        return AllDishes(
          restaurantName: args.restaurantName,
          dishes: args.dishes,
        );
      },
    ),

    // User activity
    GetPage(name: AppRoutes.notifications, page: () => Notifications()),
    GetPage(
      name: AppRoutes.followers,
      page: () {
        final args = Get.arguments as FollowersArgs;
        return Followers(profile: args.profile, initialTab: args.initialTab);
      },
    ),
    GetPage(
      name: AppRoutes.publicProfile,
      page: () => PublicProfile(profile: Get.arguments as UserProfile),
    ),

    // Profile
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfileScreen()),
    GetPage(name: AppRoutes.help, page: () => const HelpSupportScreen()),
  ];
}
