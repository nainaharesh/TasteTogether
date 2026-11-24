
 // ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/home_feed_viewmodel/tabbar_view_model.dart';
import 'package:tastetogether/views/main_application/search_results.dart';
import 'package:tastetogether/widgets/home_feed/feed_list.dart';
import 'package:tastetogether/widgets/home_feed/tabbar.dart';

class HomeFeed extends StatelessWidget {
  HomeFeed({super.key});

  final TabbarViewModel tabbarcontroller = Get.put(TabbarViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [

            // Header
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 8.w,
                top: 24.h,
              ),
              child: Row(
                children: [

                  // Logo and title
                  Expanded(
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Image.asset(
                          'assets/icons/logo.png',
                          width: 30.r,
                          height: 30.r,
                        ),

                        Flexible(
                          child: Text(
                            'TasteTogether',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search icon
                  IconButton(
                    onPressed: () => Get.to(
                      () => SearchResults(),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.tightFor(
                      width: 44.r,
                      height: 44.r,
                    ),
                    icon: ImageIcon(
                      const AssetImage('assets/icons/search.png'),
                      size: 44.r,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  // Notification bell
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints.tightFor(
                          width: 44.r,
                          height: 44.r,
                        ),
                        icon: ImageIcon(
                          const AssetImage('assets/icons/bell.png'),
                          size: 44.r,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      Positioned(
                        top: 10.h,
                        right: 11.w,
                        child: Container(
                          width: 13.r,
                          height: 13.r,
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

            // TabBar (Following | Community)
            AppTabBar(
              tabs: const ['Following', 'Community'],
              controller: tabbarcontroller.tabController,
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: tabbarcontroller.tabController,
                children: [
                  FeedList(
                    posts: tabbarcontroller.followingPosts,
                  ),
                  FeedList(
                    posts: tabbarcontroller.communityPosts,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
