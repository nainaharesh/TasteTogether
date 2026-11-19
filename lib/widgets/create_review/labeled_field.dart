// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Label (14 w500) + neeche 6 ka gap + field
class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        child,
      ],
    );
  }
}

/// Icon + text input (52 high, white, fieldBorder, radius 14)
class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.controller,
    required this.icon,
    this.hintText,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final IconData icon;
  final String? hintText;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.fieldBorder),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Icon(icon, size: 20.r, color: AppColors.textMuted),
          Expanded(
            child: TextField(
              controller: controller,
              textCapitalization: textCapitalization,
              cursorColor: AppColors.primary,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textMuted,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
