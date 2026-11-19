// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/home_feed/feed_list.dart';
import 'package:tastetogether/widgets/home_feed/tabbar.dart';

import '../../viewmodels/home_feed_viewmodel/tabbar_view_model.dart';


class HomeFeed extends StatelessWidget {
  HomeFeed({super.key});

  final TabbarViewModel tabbarcontroller = Get.put(TabbarViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // #F8F7F4
      body: SafeArea(
        child: Column(
          children: [
            //////// header ////////
            Column(
              spacing: 56,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8, top: 24),
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
                              width: 13,
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
              ],
            ),

            //////// TabBar (Following | Community) ////////
            AppTabBar(
              tabs: const ['Following', 'Community'],
              controller: tabbarcontroller.tabController,
            ),

            Expanded(
              child: TabBarView(
                controller: tabbarcontroller.tabController,
                children: [
                  FeedList(posts: tabbarcontroller.followingPosts),
                  FeedList(posts: tabbarcontroller.communityPosts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

