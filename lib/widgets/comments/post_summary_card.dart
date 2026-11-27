// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/main_application/post_models.dart';

import 'package:tastetogether/theme/appcolors.dart';

/// Comments ke upar wala "amina.eats reviewed Charred Lamb Kofta" card
class PostSummaryCard extends StatelessWidget {
  const PostSummaryCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    TextStyle bold = const TextStyle(fontWeight: FontWeight.w700);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: AppColors.photoPlaceholder2,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: post.username, style: bold),
                      const TextSpan(text: ' reviewed '),
                      TextSpan(text: post.dishName, style: bold),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${post.restaurant} · ${post.timeAgo}',
                  style: TextStyle(fontSize: 13.sp, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Row(
            spacing: 4.w,
            children: [
              Icon(Icons.star_rounded, size: 14.r, color: AppColors.primary),
              Text(
                post.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
