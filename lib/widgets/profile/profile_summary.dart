// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/user_activity/profile_model.dart';

import 'package:tastetogether/theme/appcolors.dart';

import 'package:tastetogether/widgets/common/user_avatar.dart';

/// Avatar + 3 stats (Reviews / Followers / Following) + naam + bio.
/// Profile aur Other user's profile dono yehi use karte hain.
class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    super.key,
    required this.profile,
    this.avatarStyle = 1,
    this.onFollowersTap,
    this.onFollowingTap,
  });

  final UserProfile profile;

  /// UserAvatar ka style: 1 = terracotta, 2 = charcoal
  final int avatarStyle;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 20.w,
          children: [
            UserAvatar(
              initials: profile.initials,
              size: 88,
              fontSize: 30,
              style: avatarStyle,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stat(
                    value: compactCount(profile.reviewCount),
                    label: 'Reviews',
                  ),
                  Stat(
                    value: compactCount(profile.followers),
                    label: 'Followers',
                    onTap: onFollowersTap,
                  ),
                  Stat(
                    value: compactCount(profile.following),
                    label: 'Following',
                    onTap: onFollowingTap,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Text(
            profile.name,
            style: TextStyle(
              fontSize: 18.sp,
              height: 24 / 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            profile.bio,
            style: TextStyle(
              fontSize: 14.sp,
              height: 21 / 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class Stat extends StatelessWidget {
  const Stat({super.key, required this.value, required this.label, this.onTap});

  final String value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        spacing: 2.h,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 13.sp, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
