
import 'package:get/get.dart';

import 'package:tastetogether/models/auth/auth_models.dart';
import 'package:tastetogether/models/user_activity/user_follow_model.dart';
import 'package:tastetogether/models/user_activity/user_follower_model.dart';
import 'package:tastetogether/models/user_activity/user_following_model.dart';
import 'package:tastetogether/models/user_activity/user_reviews_model.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/api/token_storage.dart';
import 'package:tastetogether/services/api_services/user_service.dart';

class UserViewModel extends GetxController {
  // API service
  final UserService userService = UserService();

  // Logged-in user's profile
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  // Another user's profile
  final Rxn<UserModel> viewedUser = Rxn<UserModel>();

  // Another user's reviews
  final RxList<UserReviewModel> userReviews =
      <UserReviewModel>[].obs;

  // User reviews pagination
  final reviewsPage = 1.obs;
  final reviewsLimit = 20.obs;

  // Another user's followers
  final RxList<FollowerUserModel> userFollowers =
      <FollowerUserModel>[].obs;

  // Followers pagination
  final followersPage = 1.obs;
  final followersLimit = 20.obs;

  // Another user's following
  final RxList<FollowingUserModel> userFollowing =
      <FollowingUserModel>[].obs;

  // Following pagination
  final followingPage = 1.obs;
  final followingLimit = 20.obs;

  // Follow API response
  final Rxn<UserFollowModel> followResponse =
      Rxn<UserFollowModel>();

  // Follow status and follower count
  final isFollowing = false.obs;
  final followerCount = 0.obs;

  // Loading state
  final isLoading = false.obs;

  // Load the logged-in user's profile
  Future<void> loadProfile() async {
    if (!TokenStorage.hasToken) return;

    await run(() async {
      currentUser.value = await userService.getMyProfile();
    });
  }

  // Update the logged-in user's profile
  Future<void> updateProfile(Map<String, dynamic> changes) async {
    await run(() async {
      currentUser.value = await userService.updateMyProfile(
        body: changes,
      );

      showSuccess('Profile updated successfully.');
    });
  }

  // Load another user's profile by ID
  Future<void> loadUserById(String otherUserId) async {
    await run(() async {
      viewedUser.value = await userService.getUserById(otherUserId);
    });
  }

  // Load another user's reviews
  Future<void> loadUserReviews({
    required String otherUserId,
    int page = 1,
    int limit = 20,
  }) async {
    await run(() async {
      final response = await userService.getUserReviews(
        otherUserId: otherUserId,
        page: page,
        limit: limit,
      );

      if (page == 1) {
        userReviews.assignAll(response.reviews);
      } else {
        userReviews.addAll(response.reviews);
      }

      reviewsPage.value = response.page;
      reviewsLimit.value = response.limit;
    });
  }

  // Load another user's followers
  Future<void> loadUserFollowers({
    required String otherUserId,
    String q = '',
    int page = 1,
    int limit = 20,
  }) async {
    await run(() async {
      final response = await userService.getUserFollowers(
        otherUserId: otherUserId,
        q: q,
        page: page,
        limit: limit,
      );

      if (page == 1) {
        userFollowers.assignAll(response.users);
      } else {
        userFollowers.addAll(response.users);
      }

      followersPage.value = response.page;
      followersLimit.value = response.limit;
    });
  }

  // Load another user's following
  Future<void> loadUserFollowing({
    required String otherUserId,
    String q = '',
    int page = 1,
    int limit = 20,
  }) async {
    await run(() async {
      final response = await userService.getUserFollowing(
        otherUserId: otherUserId,
        q: q,
        page: page,
        limit: limit,
      );

      if (page == 1) {
        userFollowing.assignAll(response.users);
      } else {
        userFollowing.addAll(response.users);
      }

      followingPage.value = response.page;
      followingLimit.value = response.limit;
    });
  }

  // Follow another user
  Future<void> followUser(String otherUserId) async {
    await run(() async {
      final response = await userService.postUserFollow(
        otherUserId: otherUserId,
      );

      followResponse.value = response;
      isFollowing.value = response.isFollowing;
      followerCount.value = response.followerCount;

     // showSuccess('User followed successfully.');
    });
  }

  // Unfollow another user
Future<void> unfollowUser(String otherUserId) async {
  await run(() async {
    final response = await userService.deleteUserFollow(
      otherUserId: otherUserId,
    );

    followResponse.value = response;
    isFollowing.value = response.isFollowing;
    followerCount.value = response.followerCount;
//no need when need it we use it like snakbar msg
    //showSuccess('User unfollowed successfully.');
  });
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

  // Show success message
  void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Show error message
  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Clear the current user profile
  void clearProfile() {
    currentUser.value = null;
  }

  // Clear another user's reviews
  void clearUserReviews() {
    userReviews.clear();
    reviewsPage.value = 1;
    reviewsLimit.value = 20;
  }

  // Clear another user's followers
  void clearUserFollowers() {
    userFollowers.clear();
    followersPage.value = 1;
    followersLimit.value = 20;
  }

  // Clear another user's following
  void clearUserFollowing() {
    userFollowing.clear();
    followingPage.value = 1;
    followingLimit.value = 20;
  }

  // Clear follow response and state
  void clearFollowData() {
    followResponse.value = null;
    isFollowing.value = false;
    followerCount.value = 0;
  }
}
