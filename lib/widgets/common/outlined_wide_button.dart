// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// "See all 248 reviews" wala outlined button (48 high)
class OutlinedWideButton extends StatelessWidget {
  const OutlinedWideButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primaryDeep,
        minimumSize: Size.fromHeight(48.h),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
