// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Small grey heading above a card: "ACCOUNT", "SUPPORT", "FREQUENTLY ASKED".
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text.toUpperCase(),
          style: GoogleFonts.dmSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.52.sp,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
