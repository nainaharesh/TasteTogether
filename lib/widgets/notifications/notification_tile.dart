// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:tastetogether/models/notification_model.dart';
import 'package:tastetogether/models/user_activity/notification_model.dart';
import 'package:tastetogether/theme/appcolors.dart';

import 'package:tastetogether/widgets/common/user_avatar.dart';

/// Notifications ki aik row: avatar + "**username** message" + time (+ unread dot) + thumbnail
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.thumbnailColor,
    required this.onTap,
  });

  final AppNotification notification;
  final Color thumbnailColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          // unread rows white, earlier rows background par
          color: n.isUnread ? AppColors.surface : null,
          border: const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          spacing: 12.w,
          children: [
            UserAvatar(
              initials: n.initials,
              size: 44,
              fontSize: 15,
              style: n.avatarStyle,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: n.username,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: ' ${n.message}'),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    spacing: 6.w,
                    children: [
                      Text(
                        n.timeAgo,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textMuted,
                        ),
                      ),
                      if (n.isUnread)
                        Container(
                          width: 7.r,
                          height: 7.r,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (n.hasThumbnail)
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: thumbnailColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: 20.r,
                  color: AppColors.textPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
