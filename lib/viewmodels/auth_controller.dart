// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/helpers/token_storage.dart';
import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/auth_service.dart';
import 'package:tastetogether/views/authentication/login_view.dart';
import 'package:tastetogether/views/authentication/welcomescreen.dart';
import 'package:tastetogether/views/main_application/bottom_navbar.dart';

/// ViewModel for all four auth screens (one controller, as requested).
/// The screens only call its methods and read its values. No UI code here.
class AuthController extends GetxController {
  // ---------------------------------------------------------------------------
  // Form keys: one per screen so each Form can be validated on its own.
  // ---------------------------------------------------------------------------
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

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

  final resetTokenController = TextEditingController();
  final resetPasswordController = TextEditingController();
  final resetConfirmController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Reactive state (only 2 variables)
  // ---------------------------------------------------------------------------
  /// true while an API call is running -> button shows a spinner.
  final isLoading = false.obs;

  /// Forgot password screen: false = email form, true = "Check your inbox".
  /// Sirf tab true hota hai jab backend ne reset email bhej di.
  final isEmailSent = false.obs;

  /// Login ke baad ka user (Profile, Home wagera isi se le sakte hain).
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  final authService = AuthService();

  /// Logout chal raha ho to 401 ko dobara "session khatam" na samjho
  bool loggingOut = false;

  @override
  void onInit() {
    super.onInit();
    // Kisi bhi API par 401 aaye to token hata kar Welcome par bhejo.
    ApiClient.onUnauthorized = forceLogout;
  }

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

  String? validateResetToken(String? value) {
    if (value == null || value.trim().isEmpty) return 'Reset code is required';
    return null;
  }

  String? validateResetConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != resetPasswordController.text) return 'Passwords do not match';
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

  /// App khulte hi (token ho to): profile background mein load. Navigation nahi.
  /// 401 ho to ApiClient.onUnauthorized khud Welcome par bhej deta hai.
  /// Internet na ho to bhi app chalti rahe, token abhi sahi hai.
  Future<void> loadProfile() async {
    if (!TokenStorage.hasToken) return;
    try {
      currentUser.value = await authService.getMyProfile();
    } catch (_) {}
  }

  Future<void> login() async {
    // Run every validator of the login Form. Stop if any field is invalid.
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      final result = await authService.login(
        email: loginEmailController.text.trim().toLowerCase(),
        password: loginPasswordController.text,
      );
      await startSession(result);
    });
  }

  Future<void> signup() async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      final result = await authService.signup(
        fullName: signupNameController.text.trim(),
        username: signupUsernameController.text.trim(),
        email: signupEmailController.text.trim().toLowerCase(),
        password: signupPasswordController.text,
      );
      await startSession(result);
    });
  }

  Future<void> sendResetLink() async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      final resetToken = await authService.forgotPassword(
        email: forgotEmailController.text.trim().toLowerCase(),
      );
      // Dev backend token seedha deta hai: Reset screen ka code field bhar do.
      if (resetToken != null) resetTokenController.text = resetToken;
      // Sirf success par "Check your inbox" dikhao.
      isEmailSent.value = true;
    });
  }

  /// Reset Password screen ka button: code + naya password -> Login.
  Future<void> resetPassword() async {
    if (!(resetFormKey.currentState?.validate() ?? false)) return;

    await run(() async {
      await authService.resetPassword(
        token: resetTokenController.text.trim(),
        newPassword: resetPasswordController.text,
      );
      clearForms();
      Get.offAll(() => LoginScreen());
      showSuccess('Password badal gaya. Ab naye password se login karein.');
    });
  }

  /// PATCH /users/me: Edit Profile aur Notification Prefs yahin se.
  /// Success par currentUser naye user se badal jata hai.
  Future<bool> updateProfile(Map<String, dynamic> changes) async {
    try {
      currentUser.value = await authService.updateMyProfile(changes);
      return true;
    } on ApiException catch (e) {
      showError(e.message);
    } catch (_) {
      showError('Kuch galat ho gaya. Dobara try karein.');
    }
    return false;
  }

  /// Settings ke "Log out" button par lagega.
  Future<void> logout() async {
    loggingOut = true;
    isLoading.value = true;
    try {
      await authService.logout();
    } catch (_) {
      // Server fail bhi ho to phone se logout ho jana chahiye.
    } finally {
      isLoading.value = false;
      loggingOut = false;
    }
    await endSession();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Loading on/off aur error ek hi jagah: login, signup, forgot sab use karte hain.
  Future<void> run(Future<void> Function() action) async {
    isLoading.value = true;
    try {
      await action();
    } on ApiException catch (e) {
      showError(e.message);
    } on FormatException {
      showError('Server ka jawab adhoora tha. Dobara try karein.');
    } catch (_) {
      showError('Kuch galat ho gaya. Dobara try karein.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Login / signup success: token save, user rakho, Home kholo.
  Future<void> startSession(AuthResponse result) async {
    await TokenStorage.saveToken(result.token);
    currentUser.value = result.user;
    clearForms();
    Get.offAll(() => BottomNavbarScreen());
    // login response mein counts / prefs na hon to poora user background mein
    loadProfile();
  }

  /// Logout ya 401: token hatao, user bhulo, Welcome par jao.
  Future<void> endSession() async {
    await TokenStorage.deleteToken();
    currentUser.value = null;
    clearForms();
    Get.offAll(() => WelcomeScreen());
  }

  void forceLogout() {
    // Ek saath kai requests 401 deti hain (Home par 3-4 hoti hain): sirf ek
    // baar chalao. Token memory se pehle hi ja chuka ho to kuch nahi karna.
    if (loggingOut || !TokenStorage.hasToken) return;
    endSession();
    showError('Session khatam ho gaya. Dobara login karein.');
  }

  void clearForms() {
    loginEmailController.clear();
    loginPasswordController.clear();
    signupNameController.clear();
    signupUsernameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    signupConfirmController.clear();
    forgotEmailController.clear();
    resetTokenController.clear();
    resetPasswordController.clear();
    resetConfirmController.clear();
    isEmailSent.value = false;
  }

  void showSuccess(String message) {
    Get.snackbar('Done', message, snackPosition: SnackPosition.BOTTOM);
  }

  void showError(String message) {
    Get.snackbar('Oops', message, snackPosition: SnackPosition.BOTTOM);
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