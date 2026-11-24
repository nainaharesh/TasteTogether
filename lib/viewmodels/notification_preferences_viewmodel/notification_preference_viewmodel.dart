import 'package:get/get.dart';

class NotificationPreferencesViewModel extends GetxController {
  final RxBool likes = true.obs;
  final RxBool comments = true.obs;
  final RxBool newFollowers = true.obs;
  final RxBool saves = false.obs;

  final RxBool weeklyDigest = true.obs;
  final RxBool tipsAndUpdates = false.obs;
}