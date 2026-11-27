// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/user_activity/person_model.dart';


class FollowersViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  FollowersViewModel({this.initialTab = 0});

  final int initialTab;

  late final TabController tabController;
  final RxInt currentTab = 0.obs;
  final RxString query = ''.obs;
  final searchController = TextEditingController();
  final RxList<Person> followers = <Person>[].obs;
  final RxList<Person> following = <Person>[].obs;

  /// Search aur current tab ke hisaab se jo list dikhni hai
  List<Person> get visible {
    final source = currentTab.value == 0 ? followers : following;
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) return source.toList();
    return source
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.username.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initialTab,
    );
    currentTab.value = initialTab;
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentTab.value = tabController.index;
      }
    });

    // TODO: Get data from api//
    // dumy data///
    followers.assignAll(dummyFollowers);
    following.assignAll(dummyFollowing);
  }

  void search(String value) => query.value = value;

  void clearSearch() {
    searchController.clear();
    query.value = '';
  }

  void toggleFollow(Person person) {
    // TODO: API - follow / unfollow
    final list = currentTab.value == 0 ? followers : following;
    final i = list.indexWhere((p) => p.id == person.id);
    if (i == -1) return;
    list[i] = person.copyWith(isFollowing: !person.isFollowing);
  }

  @override
  void onClose() {
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
