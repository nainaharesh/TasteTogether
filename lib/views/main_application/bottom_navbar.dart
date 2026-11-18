// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/views/main_application/create_review.dart';
import 'package:tastetogether/views/main_application/explore.dart';
import 'package:tastetogether/views/main_application/home_feed.dart';

import '../../viewmodels/home_feed_viewmodel/bottomnavbar_view_model.dart';

class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarViewModel controller = Get.put(BottomNavbarViewModel());

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
            () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: Container(
        height: 84,
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
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textMuted,
            selectedFontSize: 11,
            unselectedFontSize: 11,
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
                  height: 24,
                  child: OverflowBox(
                    maxHeight: 52,
                    child: Transform.translate(
                      offset: const Offset(0, 8),
                      child: GestureDetector(
                        onTap: () => Get.to(() => const CreateReview()),
                        child: Image.asset(
                          'assets/icons/add.png',
                          width: 52,
                          height: 52,
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