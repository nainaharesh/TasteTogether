import 'package:flutter/material.dart';
import 'package:get/get.dart';

// BACKEND INTEGRATION: uncomment these imports together with the API code below.
// import '../../models/auth/auth_models.dart';
// import '../../services/api_services.dart';
// import '../../utils/api_endpoints.dart';
// import '../../routes/app_routes.dart';

/// ViewModel for all four auth screens (one controller, as requested).
/// The screens only call its methods and read its values. No UI code here.
class AuthController extends GetxController {
  // ---------------------------------------------------------------------------
  // Form keys: one per screen so each Form can be validated on its own.
  // ---------------------------------------------------------------------------
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // Text controllers (separate for each screen so texts do not mix).
  // ---------------------------------------------------------------------------
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final signupNameController = TextEditingController();
  final signupUsernameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmController = TextEditingController();

  final forgotEmailController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Reactive state (only 2 variables)
  // ---------------------------------------------------------------------------
  /// true while an API call is running -> button shows a spinner.
  final isLoading = false.obs;

  /// Forgot password screen: false = email form, true = "Check your inbox".
  /// BACKEND INTEGRATION: it is set to true only inside the (commented)
  /// success branch of sendResetLink(), so it stays false for now.
  final isEmailSent = false.obs;

  // ---------------------------------------------------------------------------
  // Validators. A validator returns an error text, or null when the value is OK.
  // ---------------------------------------------------------------------------
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    // simple check: something@something.something
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    if (value.contains(' ')) return 'Username cannot contain spaces';
    return null;
  }

  /// Login: we only require a value. (Do not enforce the 8-character rule
  /// here, old accounts may have different passwords.)
  String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return null;
  }

  /// Signup: matches the hint "At least 8 characters" from the design.
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Use at least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != signupPasswordController.text) return 'Passwords do not match';
    return null;
  }

  // ---------------------------------------------------------------------------
  // Actions called by the buttons
  // ---------------------------------------------------------------------------

  Future<void> login() async {
    // Run every validator of the login Form. Stop if any field is invalid.
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    // BACKEND INTEGRATION (Login)
    // Needed from backend: URL, request keys, success response (token / user),
    // error format (wrong password, unknown email).
    //
    // isLoading.value = true;
    // try {
    //   final request = LoginRequestModel(
    //     email: loginEmailController.text.trim(),
    //     password: loginPasswordController.text,
    //   );
    //   // final response = await ApiServices.post(
    //   //   ApiEndpoints.loginUrl,
    //   //   request.toJson(),
    //   // );
    //   // TODO: check response status, save token with GetStorage, then:
    //   // Get.offAllNamed(AppRoutes.home);
    // } catch (e) {
    //   // TODO: show an error message
    // } finally {
    //   isLoading.value = false;
    // }
  }

  Future<void> signup() async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;

    // BACKEND INTEGRATION (Signup)
    // Needed from backend: URL, request keys, success response, error format
    // (email already used, username taken), and whether the user must verify
    // the email before logging in.
    //
    // isLoading.value = true;
    // try {
    //   final request = SignupRequestModel(
    //     fullName: signupNameController.text.trim(),
    //     username: signupUsernameController.text.trim(),
    //     email: signupEmailController.text.trim(),
    //     password: signupPasswordController.text,
    //   );
    //   // final response = await ApiServices.post(
    //   //   ApiEndpoints.signupUrl,
    //   //   request.toJson(),
    //   // );
    //   // TODO: check response, then go to Home or back to Login
    // } catch (e) {
    //   // TODO: show an error message
    // } finally {
    //   isLoading.value = false;
    // }
  }

  Future<void> sendResetLink() async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;

    // BACKEND INTEGRATION (Forgot password)
    // Needed from backend: URL, request key for the email, success / error
    // format, and the real link expiry time (the design text says
    // "It expires in 30 minutes", this must match the backend).
    //
    // isLoading.value = true;
    // try {
    //   final request = ForgotPasswordRequestModel(
    //     email: forgotEmailController.text.trim(),
    //   );
    //   // final response = await ApiServices.post(
    //   //   ApiEndpoints.forgotPasswordUrl,
    //   //   request.toJson(),
    //   // );
    //   // On success (and ONLY then) show the "Check your inbox" view:
    //   // isEmailSent.value = true;
    // } catch (e) {
    //   // TODO: show an error message
    // } finally {
    //   isLoading.value = false;
    // }
  }

  /// "Didn't get it? Send again": goes back to the email form (as in the design).
  void resetForgotPasswordState() {
    isEmailSent.value = false;
  }

  // ---------------------------------------------------------------------------
  // Clean up: free the memory used by the text controllers.
  // ---------------------------------------------------------------------------
  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupUsernameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmController.dispose();
    forgotEmailController.dispose();
    super.onClose();
  }
}