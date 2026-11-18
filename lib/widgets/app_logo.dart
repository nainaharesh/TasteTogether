import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/appcolors.dart';

/// Rounded terracotta square + "TasteTogether". Used on Welcome (big) and
/// Login (small). Sizes are given in design pixels.
/// If you have the real logo as an SVG, replace the Icon with SvgPicture.asset.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.boxSize = 32,
    this.iconSize = 20,
    this.radius = 10,
    this.fontSize = 20,
  });

  final double boxSize;
  final double iconSize;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: boxSize.w,
          height: boxSize.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(radius.r),
          ),
          child: Icon(Icons.trip_origin, size: iconSize.sp, color: AppColors.white),
        ),
        SizedBox(width: 10.w),
        Text(
          'TasteTogether',
          style: GoogleFonts.dmSans(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.02 * fontSize.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}