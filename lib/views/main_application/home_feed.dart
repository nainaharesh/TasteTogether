// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/homeviewmodel.dart';
import 'package:tastetogether/widgets/home_feed/post_card.dart';
import 'package:tastetogether/widgets/home_feed/tabbar.dart';

class HomeFeed extends StatelessWidget {
  HomeFeed({super.key});

  final HomeFeedViewModel vm = Get.put(HomeFeedViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // #F8F7F4
      body: SafeArea(
        child: Column(
          children: [
            //////// header ////////
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    ///// logo and title /////
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/logo.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'TasteTogether',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///// search icon /////
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 44,
                        height: 44,
                      ),
                      icon: const ImageIcon(
                        AssetImage('assets/icons/search.png'),
                        size: 44,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    ///// bell icon /////
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints.tightFor(
                            width: 44,
                            height: 44,
                          ),
                          icon: const ImageIcon(
                            AssetImage('assets/icons/bell.png'),
                            size: 44,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 11,
                          child: Container(
                            width: 13, // 9 dot + 2px border on each side
                            height: 13,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //////// TabBar (Following | Community) ////////
            AppTabBar(
              tabs: const ['Following', 'Community'],
              controller: vm.tabController,
            ),

            Expanded(
              child: TabBarView(
                controller: vm.tabController,
                children: [
                  FeedList(posts: vm.followingPosts),
                  FeedList(posts: vm.communityPosts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedList extends StatelessWidget {
  const FeedList({required this.posts});

  final RxList<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (posts.isEmpty) {
        return const Center(child: Text('No posts yet'));
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, i) {
          final p = posts[i];
          return PostCard(
            key: ValueKey(p.id),
            username: p.username,
            initials: p.initials,
            restaurant: p.restaurant,
            timeAgo: p.timeAgo,
            dishName: p.dishName,
            rating: p.rating,
            review: p.review,
            likes: p.likes,
            comments: p.comments,
            imageUrl: p.imageUrl,
            isLiked: p.isLiked,
            isSaved: p.isSaved,
          );
        },
      );
    });
  }
}
