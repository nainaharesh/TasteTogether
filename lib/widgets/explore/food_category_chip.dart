// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

class FoodCategoryChip extends StatelessWidget {
  const FoodCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        // upar neeche 4px extra sirf tap karne ki jagah barhane ke liye
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Container(
          constraints: BoxConstraints(minHeight: 36.h), // design: 36
          alignment: Alignment.center, // text ko beech mein rakhta hai
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.fieldBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              leadingDistribution: TextLeadingDistribution.even,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.surface : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> your-development
