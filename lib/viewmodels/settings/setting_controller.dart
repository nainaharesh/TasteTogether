import 'package:get/get.dart';

// import 'package:get_storage/get_storage.dart';
// import '../../services/api_services.dart';
// import '../../utils/api_endpoints.dart';
import '../../routes/app_routes.dart';
import '../auth/auth_controller.dart';

/// ViewModel of the Settings screen.
///
/// Note about GetStorage: the Settings design has NO switches or options that
/// must be remembered (every row just opens another screen), so nothing is
/// stored locally here. Nothing was invented to fill that gap.
class SettingsController extends GetxController {
  // TODO: replace with the real app version (package_info_plus) later.
  static const String appVersion = 'v1.0.0';

  /// Shown in the card at the top. Empty until real data is available.
  final userName = ''.obs;
  final userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserSummary();
  }

  Future<void> loadUserSummary() async {
    // BACKEND INTEGRATION (Get profile summary)
    // Needed from backend: the same profile endpoint used by Edit Profile.
    // (Or read the name/email from GetStorage if login saves them there.)
    //
    // final response = await ApiServices.get(ApiEndpoints.profileUrl);
    // userName.value = ...;
    // userEmail.value = ...;
  }

  Future<void> logout() async {
    // BACKEND INTEGRATION (Logout)
    // Needed from backend: whether a logout request exists, or whether the
    // app should just delete its saved token.
    //
    // try {
    //   // await ApiServices.post(ApiEndpoints.logoutUrl, {});
    // } catch (e) {
    //   // TODO: decide if logout should still continue when this fails
    // }

    // TODO: when login saves a token with GetStorage, remove it here:
    // GetStorage().remove('<token key>');

    // Local part (works without a backend):
    // delete the auth controller so typed email/password are cleared.
    // It is created again automatically the next time the Login screen opens.
    Get.delete<AuthController>(force: true);

    // offAllNamed = open Welcome and remove every previous screen,
    // so the Back button cannot return to the logged-in area.
    Get.offAllNamed(AppRoutes.welcome);
  }
}