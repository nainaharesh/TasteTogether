// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/appcolors.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/custom_button.dart';

import 'package:tastetogether/views/authentication/login_view.dart';
import 'package:tastetogether/views/authentication/signupscreen.dart';

/// Screen 1 of 4 - "01 · Welcome" in the design.
/// No controller needed: it only navigates.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
                child: Column(
                  children: [
                    // Photo collage: two columns, the right one starts lower.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              PhotoTile(
                                label: 'Photo · Ramen',
                                color: AppColors.photoPlaceholder1,
                                height: 200,
                              ),
                              SizedBox(height: 12.h),
                              PhotoTile(
                                label: 'Photo · Pastry',
                                color: AppColors.photoPlaceholder3,
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 48.h),
                            child: Column(
                              children: [
                                PhotoTile(
                                  label: 'Photo · Margherita',
                                  color: AppColors.fieldBorder,
                                  height: 150,
                                ),
                                SizedBox(height: 12.h),
                                PhotoTile(
                                  label: 'Photo · Lamb kofta',
                                  color: AppColors.photoPlaceholder2,
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    const AppLogo(boxSize: 36, fontSize: 26),
                    SizedBox(height: 12.h),
                    Text(
                      'Discover. Review. Connect.',
                      style: GoogleFonts.dmSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300.w),
                      child: Text(
                        'Honest reviews and dish ratings from people who love to eat.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 15.sp,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Get Started',
                      onPressed: () => Get.to(() => SignupScreen()),
                    ),
                    SizedBox(height: 8.h),
                    AuthFooterLink(
                      question: 'Already have an account?',
                      linkText: 'Log in',
                      onTap: () => Get.to(() => LoginScreen()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder photo (the design also shows grey placeholders here).
/// To use real photos later: replace the child with
/// Image.asset(...) inside a ClipRRect.
class PhotoTile extends StatelessWidget {
  const PhotoTile({super.key, 
    required this.label,
    required this.color,
    required this.height,
  });

  final String label;
  final Color color;
  final double height; // design pixels

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 26.sp, color: AppColors.textPrimary),
          SizedBox(height: 6.h),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
