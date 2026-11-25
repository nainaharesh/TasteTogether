// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';

import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/viewmodels/auth_controller.dart';

/// ViewModel of the Settings screen.
///
/// GetStorage: Settings design mein koi switch / option nahi jo yaad rakhna ho
/// (har row sirf dusri screen kholti hai), is liye local storage nahi.
class SettingsController extends GetxController {
  // TODO: replace with the real app version (package_info_plus) later.
  static const String appVersion = 'v1.0.0';

  final AuthController auth = Get.find<AuthController>();

  /// Top card: naam aur email, AuthController.currentUser se.
  final userName = ''.obs;
  final userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fillFrom(auth.currentUser.value);
    // Edit Profile mein naam badle to yahan bhi turant badal jaye
    ever(auth.currentUser, fillFrom);
    if (auth.currentUser.value == null) auth.loadProfile();
  }

  void fillFrom(UserModel? user) {
    userName.value = user?.fullName ?? '';
    userEmail.value = user?.email ?? '';
  }

  /// Token hatana, API logout aur Welcome par jana AuthController karta hai
  Future<void> logout() => auth.logout();
}