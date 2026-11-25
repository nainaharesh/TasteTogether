// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/main_application_models_home_feed_viewmodel_tabbar_view_model.dart';
import 'package:tastetogether/viewmodels/notification_viewmodel.dart';
import 'package:tastetogether/views/main_application/search_results.dart';
import 'package:tastetogether/views/main_application/create_review.dart';
import 'package:tastetogether/views/user_activity/notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:tastetogether/viewmodels/user_activity_models/notifications_viewmodel/notifications_view_model.dart';
import 'package:tastetogether/widgets/common/chip_row.dart';
import 'package:tastetogether/widgets/common/empty_state.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/utils/app_assets.dart';
//import 'package:tastetogether/viewmodels/main_application_models/home_feed_viewmodel/tabbar_view_model.dart';
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
            //////// header (design: 56 high) ////////
            Container(
              height: 56.h,
              padding: EdgeInsets.only(left: 16.w, right: 8.w),
              child: Row(
                children: [
                  ///// logo and title /////
                  Expanded(
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Image.asset(AppAssets.logo, width: 30.r, height: 30.r),
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

                  ///// search icon (44 box) /////
                  IconButton(
                    onPressed: () => Get.to(() => SearchResults()),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.tightFor(
                      width: 44.r,
                      height: 44.r,
                    ),
                    icon: ImageIcon(
                      const AssetImage(AppAssets.search),
                      size: 44.r,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  ///// bell icon: 24 logical, 44 touch target /////
                  // Unread ho to bellUnread asset, warna bell asset.
                  // Dot code se nahi bana, sirf asset se aata hai.
                  IconButton(
                    onPressed: () => Get.to(() => Notifications()),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints.tightFor(
                      width: 44.r,
                      height: 44.r,
                    ),
                    icon: Obx(
                      () => Image.asset(
                        notificationsController.unreadCount == 0
                            ? AppAssets.bell
                            : AppAssets.bellUnread,
                        width: 24.r,
                        height: 24.r,
                      ),
                    ),
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
                    isLoading: tabbarcontroller.isLoading,
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
                          isLoading: tabbarcontroller.isLoading,
                          emptyState: EmptyState(
                            icon: Icons.restaurant_menu_rounded,
                            title: 'Nothing here yet',
                            message: 'Be the first to review a dish and start the conversation.',
                            actionLabel: 'Write a review',
                            onAction: () => Get.to(() => CreateReview()),
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
