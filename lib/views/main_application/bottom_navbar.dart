// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/home_feed_viewmodel/bottomnavbar_view_model.dart';
import 'package:tastetogether/views/main_application/explore.dart';
import 'package:tastetogether/views/main_application/home_feed.dart';
import 'package:tastetogether/views/user_activity/profile.dart';
import 'package:tastetogether/views/user_activity/saved.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: Container(
        // minHeight: chhoti screen / gesture bar par overflow na ho
        constraints: BoxConstraints(minHeight: 84.h),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.surface,
            elevation: 0,
            iconSize: 24.r,
            // primaryDeep: choti label text ke liye (design doc ke mutabiq)
            selectedItemColor: AppColors.primaryDeep,
            unselectedItemColor: AppColors.textMuted,
            selectedFontSize: 11.sp,
            unselectedFontSize: 11.sp,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            items: [
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/home.png')),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/explore.png')),
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
                        onTap: () => Get.toNamed(AppRoutes.createReview),
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
                icon: ImageIcon(AssetImage('assets/icons/saved.png')),
                label: 'Saved',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/profile.png')),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
