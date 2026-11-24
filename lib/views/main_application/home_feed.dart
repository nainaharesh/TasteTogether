// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/viewmodels/user_activity_models/notifications_viewmodel/notifications_view_model.dart';
import 'package:tastetogether/widgets/common/chip_row.dart';
import 'package:tastetogether/widgets/common/empty_state.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/home_feed_viewmodel/tabbar_view_model.dart';
import 'package:tastetogether/widgets/home_feed/feed_list.dart';
import 'package:tastetogether/widgets/home_feed/tabbar.dart';

class HomeFeed extends StatelessWidget {
  HomeFeed({super.key});

  final TabbarViewModel tabbarcontroller = Get.put(TabbarViewModel());
  final NotificationsViewModel notificationsController = Get.put(
    NotificationsViewModel(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // #F8F7F4
      body: SafeArea(
        child: Column(
          children: [
            //////// header ////////
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 8.w, top: 24.h),
              child: Row(
                children: [
                  ///// logo and title /////
                  Expanded(
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Image.asset(
                          'assets/icons/logo.png',
                          width: 30.r,
                          height: 30.r,
                        ),
                        // choti screen / bara font par text kat jaye, Row na phate
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

                  ///// search icon /////
                  IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.searchResults),
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

                  ///// bell icon /////
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed(AppRoutes.notifications),
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
                        // dot sirf tab jab unread notifications hon
                        child: Obx(
                          () => notificationsController.unreadCount == 0
                              ? const SizedBox.shrink()
                              : Container(
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
                      ),
                    ],
                  ),
                ],
              ),
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
                  // Following: jin ko follow karte ho unki posts
                  FeedList(
                    posts: tabbarcontroller.followingPosts,
                    onLike: tabbarcontroller.toggleLike,
                    onSave: tabbarcontroller.toggleSave,
                    onRefresh: tabbarcontroller.refreshFeeds,
                    emptyState: EmptyState(
                      icon: Icons.people_outline_rounded,
                      title: 'No posts yet',
                      message: 'Follow food lovers in the Community tab to see their reviews here.',
                      actionLabel: 'Find people',
                      onAction: () => tabbarcontroller.goToTab(1),
                    ),
                  ),

                  // Community: sab ki posts + Trending / Nearby / New chips
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Obx(
                          () => ChipRow(
                            labels: TabbarViewModel.communityFilters,
                            selectedIndex:
                                tabbarcontroller.communityFilter.value,
                            onSelected: tabbarcontroller.selectCommunityFilter,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FeedList(
                          posts: tabbarcontroller.communityPosts,
                          onLike: tabbarcontroller.toggleLike,
                          onSave: tabbarcontroller.toggleSave,
                          onRefresh: tabbarcontroller.refreshFeeds,
                          emptyState: EmptyState(
                            icon: Icons.restaurant_menu_rounded,
                            title: 'Nothing here yet',
                            message: 'Be the first to review a dish and start the conversation.',
                            actionLabel: 'Write a review',
                            onAction: () => Get.toNamed(AppRoutes.createReview),
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
      ),
    );
  }
}
