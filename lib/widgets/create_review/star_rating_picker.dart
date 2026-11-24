// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// 5 bari stars (34) + rating ka label ("Great") right par
class StarRatingPicker extends StatelessWidget {
  const StarRatingPicker({
    super.key,
    required this.rating,
    required this.label,
    required this.onChanged,
  });

  final int rating;
  final String label;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Row(
        children: [
          for (var i = 1; i <= 5; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(i),
              child: SizedBox(
                width: 40.w,
                height: 44.h,
                child: Icon(
                  rating >= i ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 34.r,
                  color: rating >= i
                      ? AppColors.primary
                      : AppColors.photoPlaceholder3,
                ),
              ),
            ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDeep,
            ),
          ),
        ],
      ),
    );
  }
}
