// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/utils/app_assets.dart';


/// Design ka logo: terracotta tile (do rings) + "TasteTogether".
/// Tile asset (logo.png) ka apna rang/corner hain, is liye bina color.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.boxSize = 32, this.fontSize = 20});

  final double boxSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10.w,
      children: [
        Image.asset(AppAssets.logo, width: boxSize.r, height: boxSize.r),
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
