// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';


class HomeFeedViewModel extends GetxController
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

    // TODO: jab API aayegi to yeh dummy data hata kar repository se load hoga
    followingPosts.assignAll(_dummyPosts);
    communityPosts.assignAll(_dummyPosts.reversed);
  }

  void goToTab(int index) => tabController.animateTo(index);

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
///only for dummy data//
const _dummyPosts = <Post>[
  Post(
    id: '1',
    username: 'amina.eats',
    initials: 'AR',
    restaurant: 'Olive & Ember',
    timeAgo: '2h ago',
    dishName: 'Charred Lamb Kofta',
    rating: 5.0,
    review:
        "Smoky off the grill, with whipped feta underneath that I'd happily eat alone. Order extra flatbread.",
    likes: 129,
    comments: 14,
    isLiked: true,
  ),
  Post(
    id: '2',
    username: 'danny_dines',
    initials: 'DO',
    restaurant: 'Saffron Table',
    timeAgo: '5h ago',
    dishName: 'Butter Chicken',
    rating: 4.5,
    review: 'Creamy and rich, the naan is soft and fresh.',
    likes: 64,
    comments: 7,
  ),
  Post(
    id: '3',
    username: 'sofia.bites',
    initials: 'SM',
    restaurant: 'The Daily Crumb',
    timeAgo: '1d ago',
    dishName: 'Pistachio Croissant',
    rating: 4.0,
    review: 'Flaky outside, a little too sweet for me, but worth a try.',
    likes: 31,
    comments: 3,
  ),
];