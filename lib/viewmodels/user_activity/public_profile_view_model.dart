// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/user_activity/profile_model.dart';


class PublicProfileViewModel extends GetxController {
  PublicProfileViewModel(this.profile);

  final UserProfile profile;
  final RxBool isFollowing = false.obs;

  void toggleFollow() {
    // TODO: API call (follow / unfollow)
    isFollowing.toggle();
  }
}
