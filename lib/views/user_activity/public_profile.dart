// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/public_profile_view_model.dart';
import 'package:tastetogether/views/main_application/dish_details.dart';
import 'package:tastetogether/views/user_activity/followers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/profile_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
//import 'package:tastetogether/viewmodels/user_activity_models/public_profile_viewmodel/public_profile_view_model.dart';
import 'package:tastetogether/widgets/common/action_sheet.dart';
import 'package:tastetogether/widgets/common/app_back_button.dart';
import 'package:tastetogether/widgets/profile/follow_button.dart';
import 'package:tastetogether/widgets/profile/profile_summary.dart';
import 'package:tastetogether/widgets/profile/reviews_section.dart';

/// Screen 17 · Other User's Profile
class PublicProfile extends StatelessWidget {
  PublicProfile({super.key, required this.profile});

  final UserProfile profile;

  late final PublicProfileViewModel controller = Get.put(
    PublicProfileViewModel(profile),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(
          profile.username,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'More options',
            onPressed: () => ActionSheet.show([
              SheetAction(
                icon: Icons.link_rounded,
                label: 'Copy profile link',
                onTap: () {
                  // TODO: asli deep link jab backend ready ho
                  Clipboard.setData(
                    ClipboardData(
                      text: 'https://tastetogether.app/u/${profile.username}',
                    ),
                  );
                  Get.snackbar('Link copied', 'Profile ka link copy ho gaya.');
                },
              ),
              SheetAction(
                icon: Icons.block_rounded,
                label: 'Block ${profile.username}',
                destructive: true,
                // TODO: API - block user
                onTap: () => Get.snackbar(
                  'Blocked',
                  '${profile.username} ko block kar diya.',
                ),
              ),
              SheetAction(
                icon: Icons.flag_outlined,
                label: 'Report',
                destructive: true,
                // TODO: API - report user
                onTap: () => Get.snackbar(
                  'Reported',
                  'Thanks, we will review this profile.',
                ),
              ),
            ]),
            icon: Icon(Icons.more_horiz_rounded, size: 22.r),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: Column(
                spacing: 16.h,
                children: [
                  ProfileSummary(
                    profile: profile,
                    avatarStyle: 2,
                    onFollowersTap: () => Get.to(
                      () => Followers(profile: profile, initialTab: 0),
                    ),
                    onFollowingTap: () => Get.to(
                      () => Followers(profile: profile, initialTab: 1),
                    ),
                  ),
                  Obx(
                    () => FollowButton(
                      isFollowing: controller.isFollowing.value,
                      onPressed: controller.toggleFollow,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: ReviewsSection(
                label: 'Reviews',
                reviews: profile.reviews,
                onTap: (review) => Get.to(() => DishDetails(dish: review.dish)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
