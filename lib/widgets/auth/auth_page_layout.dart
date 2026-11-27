// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';


/// Shared frame of Login, Sign up and Forgot password:
/// background, safe area, 24px side padding, back arrow, and scrolling.
///
/// Pass the screen content in [children]. A Spacer() inside [children] pushes
/// everything after it to the bottom of the screen. If the screen is too
/// small (or the keyboard is open) the page scrolls instead of overflowing.
class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({super.key, required this.children, this.onBack});

  final List<Widget> children;

  /// Defaults to Get.back() when null.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // hasScrollBody: false -> "fill the screen, but scroll if the
            // content is taller". This is what makes Spacer() work.
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 56.h,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: onBack ?? () => Get.back(),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          constraints: BoxConstraints(
                            minWidth: 44.w,
                            minHeight: 44.h,
                          ),
                          icon: Icon(
                            Icons.arrow_back,
                            size: 24.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    ...children,
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
