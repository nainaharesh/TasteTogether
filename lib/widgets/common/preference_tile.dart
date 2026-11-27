// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/theme/appcolors.dart';


class PreferenceTile extends StatelessWidget {
  const PreferenceTile({
    super.key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      label: title,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: Container(
          constraints: BoxConstraints(minHeight: 68.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2.h,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        height: 18 / 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              PreferenceSwitch(value: value),
            ],
          ),
        ),
      ),
    );
  }
}

/// Design ka switch: 52x32 track (on = terracotta, off = #C9A892),
/// 26 white knob, 3 gap. Tap poori row par hota hai (PreferenceTile).
class PreferenceSwitch extends StatelessWidget {
  const PreferenceSwitch({super.key, required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 52.r,
      height: 32.r,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: value ? AppColors.primary : AppColors.photoPlaceholder3,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 180),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 26.r,
          height: 26.r,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}