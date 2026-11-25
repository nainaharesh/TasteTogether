// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Bottom line such as: "Already have an account? Log in".
/// Used on all four screens.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.question,
    required this.linkText,
    this.onTap,
  });

  final String question;
  final String linkText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            style: GoogleFonts.dmSans(
              fontSize: 15.sp,
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(width: 6.w),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                height: 44.h,
                child: Center(
                  child: Text(
                    linkText,
                    style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDeep,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
