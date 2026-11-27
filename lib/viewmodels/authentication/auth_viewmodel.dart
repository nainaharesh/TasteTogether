
 // ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tastetogether/services/api/token_storage.dart';
import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_exception.dart';

import 'package:tastetogether/services/api_services/auth_service.dart';

import 'package:tastetogether/views/authentication/login_view.dart';
import 'package:tastetogether/views/authentication/welcomescreen.dart';
import 'package:tastetogether/views/main_application/bottom_navbar.dart';

class AuthController extends GetxController {
  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  // Login controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Signup controllers
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Forgot password controller
  final forgotEmailController = TextEditingController();

  // Reset password controllers
  final resetTokenController = TextEditingController();
  final resetPasswordController = TextEditingController();
  final resetConfirmController = TextEditingController();

  // Observable states
  final isLoading = false.obs;
  final isEmailSent = false.obs;

  // API service
  final AuthService authService = AuthService();

  bool loggingOut = false;

  @override
  void onInit() {
    super.onInit();
    ApiClient.onUnauthorized = forceLogout;
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  // Required field validation
  String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }

    return null;
  }

  // Username validation
  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required.';
    }

    if (value.trim().length < 3) {
      return 'Username must contain at least 3 characters.';
    }

    return null;
  }

  // Login password validation
  String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    return null;
  }

  // New password validation
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < 8) {
      return 'Password must contain at least 8 characters.';
    }

    return null;
  }

  // Reset token validation
  String? validateResetToken(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Reset token is required.';
    }

    return null;
  }

  // Reset password confirmation validation
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }

    if (value != resetPasswordController.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  // Signup password confirmation validation
  String? validateSignupConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }

    if (value != signupPasswordController.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  // Login
  Future<void> login() async {
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      final response = await authService.login(
        email: loginEmailController.text.trim().toLowerCase(),
        password: loginPasswordController.text,
      );

      await startSession(response);
      showSuccess('Login successful.');
    });
  }

  // Signup
  Future<void> signup() async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      final response = await authService.signup(
        fullName: fullNameController.text.trim(),
        username: usernameController.text.trim(),
        email: signupEmailController.text.trim().toLowerCase(),
        password: signupPasswordController.text,
      );

      await startSession(response);
      showSuccess('Your account has been created successfully.');
    });
  }

  // Send password reset link
  Future<void> sendResetLink() async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      final resetToken = await authService.forgotPassword(
        email: forgotEmailController.text.trim().toLowerCase(),
      );

      if (resetToken != null && resetToken.isNotEmpty) {
        resetTokenController.text = resetToken;
      }

      isEmailSent.value = true;
      showSuccess('Password reset instructions have been sent.');
    });
  }

  // Reset password
  Future<void> resetPassword() async {
    if (!(resetFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      await authService.resetPassword(
        token: resetTokenController.text.trim(),
        newPassword: resetPasswordController.text,
      );

      clearForms();

      Get.offAll(() => LoginScreen());

      showSuccess('Password updated successfully.');
    });
  }

  // Logout
  Future<void> logout() async {
    if (loggingOut) return;

    loggingOut = true;
    isLoading.value = true;

    try {
      await authService.logout();
    } catch (_) {
      // End the local session even if the API logout request fails.
    } finally {
      await endSession();
      isLoading.value = false;
      loggingOut = false;
    }
  }

  // Handle unauthorized API responses
  void forceLogout() {
    if (loggingOut || !TokenStorage.hasToken) return;

    loggingOut = true;

    endSession().whenComplete(() {
      loggingOut = false;
    });

    showError('Your session has expired. Please log in again.');
  }

  // Execute an API operation with common error handling
  Future<void> run(Future<void> Function() operation) async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      await operation();
    } on ApiException catch (error) {
      showError(error.message);
    } on FormatException {
      showError('Invalid server response. Please try again.');
    } catch (_) {
      showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // Start a new authenticated session
  Future<void> startSession(AuthResponse response) async {
    await TokenStorage.saveToken(response.token);

    clearForms();

    Get.offAll(() => BottomNavbarScreen());
  }

  // End the current session
  Future<void> endSession() async {
    await TokenStorage.deleteToken();

    clearForms();

    Get.offAll(() => WelcomeScreen());
  }

  // Clear all form fields
  void clearForms() {
    loginEmailController.clear();
    loginPasswordController.clear();

    fullNameController.clear();
    usernameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    confirmPasswordController.clear();

    forgotEmailController.clear();

    resetTokenController.clear();
    resetPasswordController.clear();
    resetConfirmController.clear();

    resetForgotPasswordState();
  }

  // Reset forgot password state
  void resetForgotPasswordState() {
    isEmailSent.value = false;
  }

  // Show success message
  void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
    );
  }

  // Show error message
  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
  }

  @override
  void onClose() {
    // Dispose login controllers
    loginEmailController.dispose();
    loginPasswordController.dispose();

    // Dispose signup controllers
    fullNameController.dispose();
    usernameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    confirmPasswordController.dispose();

    // Dispose forgot password controller
    forgotEmailController.dispose();

    // Dispose reset password controllers
    resetTokenController.dispose();
    resetPasswordController.dispose();
    resetConfirmController.dispose();

    super.onClose();
  }
}
