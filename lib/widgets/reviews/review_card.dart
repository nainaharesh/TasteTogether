// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/review_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/star_row.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';
import 'package:tastetogether/widgets/home_feed/photo_placeholder.dart';

/// Customer review card (Restaurant Details aur Dish Details dono me)
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final photoLabel = review.photoLabel;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10.w,
            children: [
              UserAvatar(
                initials: review.initials,
                style: review.avatarStyle,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2.h,
                  children: [
                    Text(
                      review.username,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      review.date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              StarRow(rating: review.rating.toDouble()),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              review.text,
              style: TextStyle(
                fontSize: 14.sp,
                height: 21 / 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (photoLabel != null)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 160.h,
                  width: double.infinity,
                  child: PhotoPlaceholder(
                    label: photoLabel,
                    iconSize: 26,
                    spacing: 6,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
