import 'package:get/get.dart';
import 'package:tastetogether/models/profile_model.dart';

class PublicProfileViewModel extends GetxController {
  PublicProfileViewModel(this.profile);

  final UserProfile profile;
  final RxBool isFollowing = false.obs;

  void toggleFollow() {
    // TODO: API call (follow / unfollow)
    isFollowing.toggle();
  }
}
