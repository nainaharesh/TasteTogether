// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

import '../common/star_row.dart';


/// Badi rating (4.7) + stars + 5 se 1 tak ke bars
class RatingSummaryCard extends StatelessWidget {
  const RatingSummaryCard({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.share,
  });

  final double rating;
  final int ratingCount;

  /// 5 star se 1 star tak (0 se 1)
  final List<double> share;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        spacing: 20.w,
        children: [
          Column(
            spacing: 4.h,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 44 / 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                  color: AppColors.textPrimary,
                ),
              ),
              StarRow(rating: rating),
              Text(
                '$ratingCount ratings',
                style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
              ),
            ],
          ),
          Expanded(
            child: Column(
              spacing: 6.h,
              children: [
                for (var i = 0; i < share.length; i++)
                  Row(
                    spacing: 8.w,
                    children: [
                      SizedBox(
                        width: 8.w,
                        child: Text(
                          '${5 - i}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.r),
                          child: LinearProgressIndicator(
                            value: share[i],
                            minHeight: 6.h,
                            backgroundColor: AppColors.border,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
