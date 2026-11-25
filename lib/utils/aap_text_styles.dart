// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/appcolors.dart';

/// Every text style used by the auth screens (font: DM Sans, as in the design).
/// They are getters (not const fields) because `.sp` needs ScreenUtil to be
/// initialised first.
class AppTextStyles {
  AppTextStyles._();

  // "Welcome back", "Create account", "Forgot password?" -> 32/40 bold
  static TextStyle get heading => GoogleFonts.dmSans(
    fontSize: 32.sp,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.64.sp,
    color: AppColors.textPrimary,
  );

  // "Check your inbox" -> 28/36 bold
  static TextStyle get headingMedium => GoogleFonts.dmSans(
    fontSize: 28.sp,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.56.sp,
    color: AppColors.textPrimary,
  );

  // "Discover. Review. Connect."
  static TextStyle get tagline => GoogleFonts.dmSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Grey 15px paragraph under headings
  static TextStyle get subtitle => GoogleFonts.dmSans(
    fontSize: 15.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Label above each input
  static TextStyle get label => GoogleFonts.dmSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Text typed by the user
  static TextStyle get input =>
      GoogleFonts.dmSans(fontSize: 16.sp, color: AppColors.textPrimary);

  static TextStyle get hint =>
      GoogleFonts.dmSans(fontSize: 16.sp, color: AppColors.textSecondary);

  static TextStyle get button => GoogleFonts.dmSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  // "Already have an account?"
  static TextStyle get footerText =>
      GoogleFonts.dmSans(fontSize: 15.sp, color: AppColors.textSecondary);

  // "Log in", "Sign up", "Send again"
  static TextStyle get link => GoogleFonts.dmSans(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  // "Forgot password?" on the login screen
  static TextStyle get linkSmall => GoogleFonts.dmSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryDark,
  );

  static TextStyle get error =>
      GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.error);

  // ---------------------------------------------------------------------------
  // NEW: Edit Profile, Settings, Help and support
  // ---------------------------------------------------------------------------

  // Page title in the top bar: "Edit Profile", "Settings", "Help and support"
  static TextStyle get pageTitle => GoogleFonts.dmSans(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2.sp,
    color: AppColors.textPrimary,
  );

  // Small grey heading above a card: "ACCOUNT", "SUPPORT", "FREQUENTLY ASKED"
  static TextStyle get sectionLabel => GoogleFonts.dmSans(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.52.sp,
    color: AppColors.textSecondary,
  );

  // Row title inside a card: "Edit profile", "Privacy settings"
  static TextStyle get rowTitle => GoogleFonts.dmSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Small grey text: email under the name, "v1.0.0", "No articles found."
  static TextStyle get meta =>
      GoogleFonts.dmSans(fontSize: 13.sp, color: AppColors.textSecondary);

  // Tiny grey text: the "66 / 160" bio counter
  static TextStyle get caption =>
      GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.textSecondary);

  // FAQ question
  static TextStyle get faqQuestion => GoogleFonts.dmSans(
    fontSize: 15.sp,
    height: 21 / 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // FAQ answer
  static TextStyle get faqAnswer => GoogleFonts.dmSans(
    fontSize: 14.sp,
    height: 21 / 14,
    color: AppColors.textSecondary,
  );
}
