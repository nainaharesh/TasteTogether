// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const SearchTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      cursorColor: AppColors.primary,
      style: TextStyle(fontSize: 15.sp, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.textMuted),

        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(left: 14.w, right: 10.w),
                child: prefixIcon,
              ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        // filter button right se 4px
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: suffixIcon,
              ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: prefixIcon == null
            ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h)
            : EdgeInsets.symmetric(vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
