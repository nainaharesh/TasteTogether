// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/main_application/main_application_models_home_feed_viewmodel_bottomnavbar_view_model.dart';
import 'package:tastetogether/viewmodels/user_activity/profile_view_model.dart';
import 'package:tastetogether/viewmodels/user_activity/saved_view_model.dart';

import 'package:tastetogether/views/main_application/resturant_details.dart';
import 'package:tastetogether/views/user_activity/settings_screen.dart';
import 'package:tastetogether/views/user_activity/edit_profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:tastetogether/viewmodels/user_activity_models/saved_viewmodel/saved_view_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
//import 'package:tastetogether/viewmodels/main_application_models/home_feed_viewmodel/bottomnavbar_view_model.dart';
//import 'package:tastetogether/viewmodels/user_activity_models/profile_viewmodel/profile_view_model.dart';
import 'package:tastetogether/widgets/common/nav_card.dart';
import 'package:tastetogether/widgets/common/outlined_wide_button.dart';
import 'package:tastetogether/widgets/profile/profile_summary.dart';
import 'package:tastetogether/widgets/profile/reviews_section.dart';

/// Screen 09 · User Profile (bottom navbar ka 5th tab)
class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileViewModel controller = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 16.w,
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
            tooltip: 'Settings',
            onPressed: () => Get.to(() => SettingsScreen()),
            icon: Icon(Icons.settings_outlined, size: 24.r),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: Column(
                spacing: 12.h,
                children: [
                  ProfileSummary(profile: profile),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h), // 12 + 4 = 16
                    child: OutlinedWideButton(
                      label: 'Edit Profile',
                      onPressed: () => Get.to(() => EditProfileScreen()),
                    ),
                  ),
                  Obx(
                    () => NavCard(
                      icon: Icons.bookmark_border_rounded,
                      title: 'Saved places',
                      subtitle:
                          '${Get.find<SavedViewModel>().places.length} restaurants and dishes',
                      // Saved bottom navbar ka 4th tab hai
                      onTap: () =>
                          Get.find<BottomNavbarViewModel>().changeIndex(3),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: ReviewsSection(
                label: 'My reviews',
                reviews: profile.reviews,
                onTap: (review) => Get.to(
                  () => ResturantDetails(restaurant: review.restaurant),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
