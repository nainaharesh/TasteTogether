// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';

class TabbarViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  final RxInt currentTab = 0.obs;
  final RxList<Post> followingPosts = <Post>[].obs;
  final RxList<Post> communityPosts = <Post>[].obs;

  /// Community tab ke upar ki chips
  static const List<String> communityFilters = ['Trending', 'Nearby', 'New'];
  final RxInt communityFilter = 0.obs;

  /// API ka asli order (newest pehle), "New" / "Nearby" isi order mein dikhate hain
  final List<String> _communityOrder = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentTab.value = tabController.index;
      }
    });

    // TODO: Get data from api//
    // dumy data///
    followingPosts.assignAll(dummyPosts);
    communityPosts.assignAll(dummyPosts.reversed);
    _communityOrder.addAll(communityPosts.map((p) => p.id));
    _sortCommunity();
  }

  void goToTab(int index) => tabController.animateTo(index);

  void selectCommunityFilter(int index) {
    communityFilter.value = index;
    _sortCommunity();
  }

  void _sortCommunity() {
    final list = communityPosts.toList();
    if (communityFilter.value == 0) {
      // Trending: sab se zyada likes
      list.sort((a, b) => b.likes.compareTo(a.likes));
    } else {
      // New: API ka order. Nearby: TODO location ke saath API se aayega
      list.sort(
        (a, b) => _communityOrder
            .indexOf(a.id)
            .compareTo(_communityOrder.indexOf(b.id)),
      );
    }
    communityPosts.assignAll(list);
  }

  void toggleLike(String id) {
    // TODO: API - like / unlike post
    _update(
      id,
      (p) => p.copyWith(
        isLiked: !p.isLiked,
        likes: p.isLiked ? p.likes - 1 : p.likes + 1,
      ),
    );
  }

  void toggleSave(String id) {
    // TODO: API - save / unsave post
    _update(id, (p) => p.copyWith(isSaved: !p.isSaved));
  }

  /// Dono tabs mein wohi post ho sakti hai, is liye dono lists update hoti hain
  void _update(String id, Post Function(Post) change) {
    for (final list in [followingPosts, communityPosts]) {
      final i = list.indexWhere((p) => p.id == id);
      if (i != -1) list[i] = change(list[i]);
    }
  }

  /// Pull to refresh
  Future<void> refreshFeeds() async {
    // TODO: API se dobara fetch karna
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
