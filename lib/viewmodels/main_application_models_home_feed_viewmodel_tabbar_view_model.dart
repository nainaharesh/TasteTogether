
 // ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/feed_service.dart';

class TabbarViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  final RxInt currentTab = 0.obs;

  final RxList<Post> followingPosts = <Post>[].obs;
  final RxList<Post> communityPosts = <Post>[].obs;

  /// True jab tak feed load ho rahi hai.
  final RxBool isLoading = false.obs;

  final FeedService _feedService = FeedService();

  /// Community tab ke upar ki chips.
  static const List<String> communityFilters = [
    'Trending',
    'Nearby',
    'New',
  ];

  final RxInt communityFilter = 0.obs;

  /// API ka original order (newest pehle).
  final List<String> communityOrder = [];

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentTab.value = tabController.index;
      }
    });

    // Load feeds from API when screen opens.
    refreshFeeds();
  }

  /// Switch between Following and Community tabs.
  void goToTab(int index) {
    tabController.animateTo(index);
  }

  /// Select Community filter.
  void selectCommunityFilter(int index) {
    communityFilter.value = index;
    sortCommunity();
  }

  /// Sort Community posts according to selected filter.
  void sortCommunity() {
    final list = communityPosts.toList();

    if (communityFilter.value == 0) {
      // Trending: Most liked posts first.
      list.sort(
        (a, b) => b.likes.compareTo(a.likes),
      );
    } else {
      // New: Original API order.
      // Nearby: TODO - Location-based API integration.
      list.sort(
        (a, b) => communityOrder
            .indexOf(a.id)
            .compareTo(communityOrder.indexOf(b.id)),
      );
    }

    communityPosts.assignAll(list);
  }

  /// Like / Unlike post.
  void toggleLike(String id) {
    // TODO: API - like / unlike post.

    updatePost(
      id,
      (p) => p.copyWith(
        isLiked: !p.isLiked,
        likes: p.isLiked ? p.likes - 1 : p.likes + 1,
      ),
    );

    // Update Trending order after likes change.
    if (communityFilter.value == 0) {
      sortCommunity();
    }
  }

  /// Save / Unsave post.
  void toggleSave(String id) {
    // TODO: API - save / unsave post.

    updatePost(
      id,
      (p) => p.copyWith(
        isSaved: !p.isSaved,
      ),
    );
  }

  /// Update post in both lists.
  /// Same post can exist in Following and Community.
  ///
  /// Named updatePost to avoid conflict with GetxController.update().
  void updatePost(String id, Post Function(Post) change) {
    for (final list in [followingPosts, communityPosts]) {
      final index = list.indexWhere((p) => p.id == id);

      if (index != -1) {
        list[index] = change(list[index]);
      }
    }
  }

  /// Pull to refresh.
  /// Fetches both Following and Community feeds from API.
  /// If one tab fails, the other can still display its data.
  Future<void> refreshFeeds() async {
    isLoading.value = true;

    String? error;

    Future<List<Post>?> load(String tab) async {
      try {
        return await _feedService.getHomeFeed(tab: tab);
      } on ApiException catch (e) {
        error ??= e.message;
      } catch (_) {
        error ??=
            'Server ka jawab samajh nahi aaya. Dobara try karein.';
      }

      return null;
    }

    try {
      final results = await Future.wait([
        load(FeedService.followingTab),
        load(FeedService.communityTab),
      ]);

      final following = results[0];
      final community = results[1];

      // Update Following feed if API succeeds.
      if (following != null) {
        followingPosts.assignAll(following);
      }

      // Update Community feed if API succeeds.
      if (community != null) {
        communityPosts.assignAll(community);

        communityOrder
          ..clear()
          ..addAll(community.map((p) => p.id));

        sortCommunity();
      }

      if (error != null) {
        Get.snackbar(
          'Oops',
          error!,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
