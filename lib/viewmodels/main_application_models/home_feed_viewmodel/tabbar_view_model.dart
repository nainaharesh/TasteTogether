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

  }

  void goToTab(int index) => tabController.animateTo(index);

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
