// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/notification_preference_viewmodel.dart';
import 'package:tastetogether/widgets/components/app_card.dart';
import 'package:tastetogether/widgets/components/app_page_layout.dart';
import 'package:tastetogether/widgets/components/section_label.dart';
import 'package:tastetogether/widgets/profile/preference_tile.dart';


/// Screen 19 · Notification preferences (Settings se khulti hai).
class NotificationPreferencesScreen
    extends GetView<NotificationPreferencesViewModel> {
  const NotificationPreferencesScreen({super.key});

  @override
  NotificationPreferencesViewModel get controller =>
      Get.put(NotificationPreferencesViewModel());

  Widget divider() => const Divider(height: 1, color: AppColors.border);

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Notification preferences',
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            'Choose what you want to hear about. You can change this any time.',
            style: GoogleFonts.dmSans(
              fontSize: 15.sp,
              height: 22 / 15,
              color: AppColors.textMuted,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: const SectionLabel('Push notifications'),
        ),
        AppCard(
          child: Obx(
            () => Column(
              children: [
                PreferenceTile(
                  title: 'Likes',
                  description: 'When someone likes your review',
                  value: controller.likes.value,
                  onChanged: (v) => controller.setPush(controller.likes, v),
                ),
                divider(),
                PreferenceTile(
                  title: 'Comments',
                  description: 'When someone comments on your review',
                  value: controller.comments.value,
                  onChanged: (v) => controller.setPush(controller.comments, v),
                ),
                divider(),
                PreferenceTile(
                  title: 'New followers',
                  description: 'When someone starts following you',
                  value: controller.newFollowers.value,
                  onChanged: (v) =>
                      controller.setPush(controller.newFollowers, v),
                ),
                divider(),
                PreferenceTile(
                  title: 'Saves',
                  description: 'When someone saves your review',
                  value: controller.saves.value,
                  onChanged: (v) => controller.setPush(controller.saves, v),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: const SectionLabel('Email'),
        ),
        AppCard(
          child: Obx(
            () => Column(
              children: [
                PreferenceTile(
                  title: 'Weekly digest',
                  description: 'Top reviews from people you follow',
                  value: controller.weeklyDigest.value,
                  onChanged: (v) =>
                      controller.setEmail(controller.weeklyDigest, v),
                ),
                divider(),
                PreferenceTile(
                  title: 'Tips and updates',
                  description: 'News about new features',
                  value: controller.tipsAndUpdates.value,
                  onChanged: (v) =>
                      controller.setEmail(controller.tipsAndUpdates, v),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}