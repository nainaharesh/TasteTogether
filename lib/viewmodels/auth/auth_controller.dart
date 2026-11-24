import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import '../../models/auth/auth_models.dart';
import '../../routes/app_routes.dart';
import '../../services/api/api_client.dart';
import '../../services/api/api_exception.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage.dart';

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
  /// Sirf tab true hota hai jab backend ne reset email bhej di.
  final isEmailSent = false.obs;

  /// Login ke baad ka user (Profile, Home wagera isi se le sakte hain).
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  final _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    // Kisi bhi API par 401 aaye to token hata kar Welcome par bhejo.
    ApiClient.onUnauthorized = _forceLogout;
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != signupPasswordController.text) return 'Passwords do not match';
    return null;
  }

  // ---------------------------------------------------------------------------
  // Actions called by the buttons
  // ---------------------------------------------------------------------------

  /// Splash par: pehle se login hai ya nahi.
  Future<void> checkSession() async {
    if (!TokenStorage.hasToken) {
      Get.offAllNamed(AppRoutes.welcome);
      return;
    }
    try {
      currentUser.value = await _authService.getMyProfile();
    } on ApiException catch (e) {
      // 401 ho to ApiClient.onUnauthorized pehle hi Welcome par bhej chuka hai.
      if (e.isUnauthorized) return;
      // Internet na ho to bhi Home kholo, token abhi sahi hai.
    } catch (_) {
      // Response ka format ajeeb ho to bhi Home kholo.
    }
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> login() async {
    // Run every validator of the login Form. Stop if any field is invalid.
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    await _run(() async {
      final result = await _authService.login(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text,
      );
      await _startSession(result);
    });
  }

  Future<void> signup() async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;

    await _run(() async {
      final result = await _authService.signup(
        fullName: signupNameController.text.trim(),
        username: signupUsernameController.text.trim(),
        email: signupEmailController.text.trim(),
        password: signupPasswordController.text,
      );
      await _startSession(result);
    });
  }

  Future<void> sendResetLink() async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;

    await _run(() async {
      await _authService.forgotPassword(
        email: forgotEmailController.text.trim(),
      );
      // Sirf success par "Check your inbox" dikhao.
      isEmailSent.value = true;
    });
  }

  /// Settings ke "Log out" button par lagega.
  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _authService.logout();
    } catch (_) {
      // Server fail bhi ho to phone se logout ho jana chahiye.
    } finally {
      isLoading.value = false;
    }
    await _endSession();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Loading on/off aur error ek hi jagah: login, signup, forgot sab use karte hain.
  Future<void> _run(Future<void> Function() action) async {
    isLoading.value = true;
    try {
      await action();
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Server ka jawab samajh nahi aaya. Dobara try karein.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Login / signup success: token save, user rakho, Home kholo.
  Future<void> _startSession(AuthResponse result) async {
    await TokenStorage.saveToken(result.token);
    currentUser.value = result.user;
    _clearForms();
    Get.offAllNamed(AppRoutes.home);
  }

  /// Logout ya 401: token hatao, user bhulo, Welcome par jao.
  Future<void> _endSession() async {
    await TokenStorage.deleteToken();
    currentUser.value = null;
    _clearForms();
    Get.offAllNamed(AppRoutes.welcome);
  }

  void _forceLogout() {
    _endSession();
    _showError('Session khatam ho gaya. Dobara login karein.');
  }

  void _clearForms() {
    loginEmailController.clear();
    loginPasswordController.clear();
    signupNameController.clear();
    signupUsernameController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    signupConfirmController.clear();
    forgotEmailController.clear();
    isEmailSent.value = false;
  }

  void _showError(String message) {
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