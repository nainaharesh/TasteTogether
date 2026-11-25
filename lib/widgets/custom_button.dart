// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Full-width button.
/// Default: filled terracotta (52 high, radius 14).
/// isOutlined: white button with a terracotta border (Log out, Report a problem).
/// While isLoading is true it shows a spinner and ignores taps.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, // optional: null means a disabled button
    this.isLoading = false,
    this.isOutlined = false,
    this.icon, // optional icon before the text
    this.height = 52, // the Help buttons are 48
    this.fontSize = 16, // the Help buttons use 15
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final Color contentColor = isOutlined
        ? AppColors.primaryDeep
        : AppColors.surface;
    final Color backgroundColor = isOutlined
        ? AppColors.surface
        : AppColors.primary;

    return SizedBox(
      width: double.infinity,
      height: height.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: contentColor,
          // keep the same look while loading (disabled)
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: contentColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: isOutlined
                ? const BorderSide(color: AppColors.primary, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: contentColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20.sp, color: contentColor),
                    SizedBox(width: 8.w),
                  ],
                  // Flexible lets long text shrink instead of overflowing
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.surface,
                      ).copyWith(fontSize: fontSize.sp, color: contentColor),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
