// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/home_feed_viewmodel/bottomnavbar_view_model.dart';
import 'package:tastetogether/views/main_application/create_review.dart';
import 'package:tastetogether/views/main_application/explore.dart';
import 'package:tastetogether/views/main_application/home_feed.dart';
import 'package:tastetogether/views/followers_screen.dart';

class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarViewModel controller = Get.put(
    BottomNavbarViewModel(),
  );

  final List<Widget> pages = [
    HomeFeed(),
    Explore(),
    const SizedBox.shrink(),
    const Center(child: Text('Saved')),
    const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(minHeight: 84.h),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border),
          ),
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              if (index == 2) {
                Get.to(() =>  CreateReview());
              } else if (index == 4) {
                controller.changeIndex(index);
                Get.to(() => const FollowersScreen());
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
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            items: [
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/home.png'),
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/explore.png'),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 24.h,
                  child: OverflowBox(
                    maxHeight: 52.r,
                    child: Transform.translate(
                      offset: Offset(0, 8.h),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => CreateReview(),
                        ),
                        child: Image.asset(
                          'assets/icons/add.png',
                          width: 52.r,
                          height: 52.r,
                        ),
                      ),
                    ),
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/saved.png'),
                ),
                label: 'Saved',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/profile.png'),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}