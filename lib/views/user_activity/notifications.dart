// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/main_application_models_home_feed_viewmodel_bottomnavbar_view_model.dart';
import 'package:tastetogether/viewmodels/notification_viewmodel.dart';
import 'package:tastetogether/views/user_activity/public_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/notification_model.dart';
import 'package:tastetogether/models/profile_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/app_back_button.dart';

import 'package:tastetogether/widgets/common/empty_state.dart';
import 'package:tastetogether/widgets/notifications/notification_tile.dart';

/// Screen 08 · Notifications (Home ke bell se khulti hai)
class Notifications extends StatelessWidget {
  Notifications({super.key});

  // Home pehle hi isay bana deta hai (bell ka dot), warna yahan bana lo
  final NotificationsViewModel controller =
      Get.isRegistered<NotificationsViewModel>()
      ? Get.find<NotificationsViewModel>()
      : Get.put(NotificationsViewModel());

  static const thumbColors = [
    AppColors.photoPlaceholder2, // #DCC5B3
    AppColors.fieldBorder, // #D2B7A3
    AppColors.photoPlaceholder3, // #C9A892
    AppColors.photoPlaceholder1, // #E2CDBD
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // screen band hone par sab "read" ho jati hain (bell ka dot hat jata hai)
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) controller.markAllRead();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          centerTitle: false,
          leading: const AppBackButton(),
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
        ),
        body: Obx(() {
          final unread = controller.unread;
          final earlier = controller.earlier;

          if (unread.isEmpty && earlier.isEmpty) {
            return SingleChildScrollView(
              child: EmptyState(
                icon: Icons.notifications_none_rounded,
                title: 'No notifications yet',
                message: 'Likes, comments and new followers will show up here.',
                actionLabel: 'Explore restaurants',
                onAction: () {
                  Get.back();
                  Get.find<BottomNavbarViewModel>().changeIndex(1);
                },
              ),
            );
          }

          Widget tile(int i, List<AppNotification> items) => NotificationTile(
            notification: items[i],
            thumbnailColor: thumbColors[i % thumbColors.length],
            // TODO: like/comment par us review ki screen, follow par profile
            onTap: () =>
                Get.to(() => PublicProfile(profile: dummyPublicProfile)),
          );

          return ListView(
            children: [
              if (unread.isNotEmpty) ...[
                const NotificationSectionLabel('New'),
                for (var i = 0; i < unread.length; i++) tile(i, unread),
              ],
              if (earlier.isNotEmpty) ...[
                NotificationSectionLabel('Earlier', topGap: unread.isNotEmpty),
                for (var i = 0; i < earlier.length; i++) tile(i, earlier),
              ],
            ],
          );
        }),
      ),
    );
  }
}

class NotificationSectionLabel extends StatelessWidget {
  const NotificationSectionLabel(this.label, {super.key, this.topGap = false});

  final String label;
  final bool topGap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topGap ? 8.h : 0),
      child: Container(
        constraints: BoxConstraints(minHeight: 36.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.centerLeft,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.52, // 0.04em
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
