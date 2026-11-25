// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/viewmodels/auth_controller.dart';

class NotificationPreferencesViewModel extends GetxController {
  final AuthController auth = Get.find<AuthController>();

  final RxBool likes = true.obs;
  final RxBool comments = true.obs;
  final RxBool newFollowers = true.obs; // backend: follows
  final RxBool saves = true.obs;

  final RxBool weeklyDigest = true.obs; // backend: digest
  final RxBool tipsAndUpdates = true.obs; // backend: tips

  @override
  void onInit() {
    super.onInit();
    fillFrom(auth.currentUser.value);
    // profile baad mein load ho ya save ke baad badle, switches sync rahen
    ever(auth.currentUser, fillFrom);
    if (auth.currentUser.value == null) auth.loadProfile();
  }

  void fillFrom(UserModel? user) {
    if (user == null) return;
    likes.value = user.pushPrefs.likes;
    comments.value = user.pushPrefs.comments;
    newFollowers.value = user.pushPrefs.follows;
    saves.value = user.pushPrefs.saves;
    weeklyDigest.value = user.emailPrefs.digest;
    tipsAndUpdates.value = user.emailPrefs.tips;
  }

  Map<String, dynamic> get pushBody => {
    'pushPrefs': {
      'likes': likes.value,
      'comments': comments.value,
      'follows': newFollowers.value,
      'saves': saves.value,
    },
  };

  Map<String, dynamic> get emailBody => {
    'emailPrefs': {'digest': weeklyDigest.value, 'tips': tipsAndUpdates.value},
  };

  Future<void> setPush(RxBool setting, bool value) =>
      save(setting, value, () => pushBody);

  Future<void> setEmail(RxBool setting, bool value) =>
      save(setting, value, () => emailBody);

  /// Switch turant badalta hai; server fail kare to wapas purani value.
  Future<void> save(
    RxBool setting,
    bool value,
    Map<String, dynamic> Function() body,
  ) async {
    final old = setting.value;
    setting.value = value;
    final ok = await auth.updateProfile(body());
    if (!ok) setting.value = old;
  }
}