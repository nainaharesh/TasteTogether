// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/utils/app_assets.dart';
import 'package:tastetogether/viewmodels/main_application/main_application_models_home_feed_viewmodel_bottomnavbar_view_model.dart';
//import 'package:tastetogether/viewmodels/main_application_models_home_feed_viewmodel_bottomnavbar_view_model.dart';
import 'package:tastetogether/views/main_application/create_review.dart';
import 'package:tastetogether/views/main_application/explore.dart';
import 'package:tastetogether/views/main_application/home_feed.dart';
import 'package:tastetogether/views/user_activity/profile.dart';
import 'package:tastetogether/views/user_activity/saved.dart';
//import 'package:tastetogether/viewmodels/main_application_models/home_feed_viewmodel/bottomnavbar_view_model.dart';

class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarViewModel controller = Get.put(BottomNavbarViewModel());

  final List<Widget> pages = [
    HomeFeed(),
    Explore(),
    const SizedBox.shrink(),
    Saved(),
    Profile(),
  ];

  /// Design: active icon = primary (#B65C45), active label = primaryDeep.
  /// Is liye activeIcon alag rang mein; label ka rang selectedItemColor se.
  BottomNavigationBarItem navItem(String asset, String label) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(asset)),
      activeIcon: ImageIcon(AssetImage(asset), color: AppColors.primary),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(minHeight: 84.h),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              if (index == 2) {
                Get.to(() => CreateReview());
              } else {
                controller.changeIndex(index);
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.surface,
            elevation: 0,
            iconSize: 24.r,
            selectedItemColor: AppColors.primaryDeep,
            unselectedItemColor: AppColors.textMuted,
            selectedFontSize: 11.sp,
            unselectedFontSize: 11.sp,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            items: [
              navItem(AppAssets.home, 'Home'),
              navItem(AppAssets.explore, 'Explore'),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 24.h,
                  child: OverflowBox(
                    maxHeight: 52.r,
                    child: Transform.translate(
                      offset: Offset(0, 8.h),
                      child: Image.asset(
                        AppAssets.add,
                        width: 52.r,
                        height: 52.r,
                      ),
                    ),
                  ),
                ),
                label: '',
              ),
              navItem(AppAssets.saved, 'Saved'),
              navItem(AppAssets.profile, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
