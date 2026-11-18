import 'package:get/get.dart';
import '../views/authentication/forgetpasswordscreen.dart';
import '../views/authentication/login_view.dart';
import '../views/authentication/signupscreen.dart';
import '../views/authentication/welcomescreen.dart';
class AppRoutes {
  AppRoutes._();

  static const String welcome = '/welcome';
  static const String login = '/login';
static const String signup = '/signup';
static const String forgotPassword = '/forgot-password';
}


class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
  ];
}