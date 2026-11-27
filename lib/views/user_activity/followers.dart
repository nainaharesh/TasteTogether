// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/models/user_activity/profile_model.dart';

import 'package:tastetogether/viewmodels/user_activity/followers.dart';
import 'package:tastetogether/views/user_activity/public_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/app_back_button.dart';
import 'package:tastetogether/widgets/common/empty_state.dart';
import 'package:tastetogether/widgets/explore/custom_searchfield.dart';
import 'package:tastetogether/widgets/home_feed/tabbar.dart';
import 'package:tastetogether/widgets/profile/person_tile.dart';

/// Screen 18 · Followers / Following (profile ke stats par tap se khulti hai)
class Followers extends StatelessWidget {
  Followers({super.key, required this.profile, this.initialTab = 0});

  final UserProfile profile;
  final int initialTab;

  late final FollowersViewModel controller = Get.put(
    FollowersViewModel(initialTab: initialTab),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        leading: const AppBackButton(),
        title: Text(
          profile.username,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: Column(
        children: [
          // 2 barabar tabs (design: flex 1 + flex 1)
          AppTabBar(
            isScrollable: false,
            controller: controller.tabController,
            tabs: [
              '${compactCount(profile.followers)} Followers',
              '${compactCount(profile.following)} Following',
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
            child: Obx(
              () => SearchTextField(
                hintText: controller.currentTab.value == 0
                    ? 'Search followers'
                    : 'Search following',
                controller: controller.searchController,
                onChanged: controller.search,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20.r,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final list = controller.visible;
              if (list.isEmpty) {
                return SingleChildScrollView(
                  child: EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'No results',
                    message: 'Try a different name or username.',
                    actionLabel: 'Clear search',
                    onAction: controller.clearSearch,
                  ),
                );
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => PersonTile(
                  person: list[i],
                  // TODO: us banday ka profile API se (username/id se)
                  onTap: () =>
                      Get.to(() => PublicProfile(profile: dummyPublicProfile)),
                  onToggleFollow: () => controller.toggleFollow(list[i]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
