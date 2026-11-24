import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';

import '../../theme/appcolors.dart';
import '../../utils/aap_text_styles.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/custom_button.dart';

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
                              _PhotoTile(
                                label: 'Photo · Ramen',
                                color: AppColors.tile1,
                                height: 200,
                              ),
                              SizedBox(height: 12.h),
                              _PhotoTile(
                                label: 'Photo · Pastry',
                                color: AppColors.tile2,
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
                                _PhotoTile(
                                  label: 'Photo · Margherita',
                                  color: AppColors.tile3,
                                  height: 150,
                                ),
                                SizedBox(height: 12.h),
                                _PhotoTile(
                                  label: 'Photo · Lamb kofta',
                                  color: AppColors.tile4,
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    const AppLogo(
                      boxSize: 36,
                      iconSize: 22,
                      radius: 11,
                      fontSize: 26,
                    ),
                    SizedBox(height: 12.h),
                    Text('Discover. Review. Connect.', style: AppTextStyles.tagline),
                    SizedBox(height: 8.h),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300.w),
                      child: Text(
                        'Honest reviews and dish ratings from people who love to eat.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subtitle,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Get Started',
                      onPressed: () => Get.toNamed(AppRoutes.signup),
                    ),
                    SizedBox(height: 8.h),
                    AuthFooterLink(
                      question: 'Already have an account?',
                      linkText: 'Log in',
                      onTap: () => Get.toNamed(AppRoutes.login),
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
/// Image.asset(AppAssets.photoRamen, fit: BoxFit.cover) inside a ClipRRect.
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
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