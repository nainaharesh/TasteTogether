import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/appcolors.dart';
import '../../utils/aap_text_styles.dart';


/// Shared frame of Edit Profile, Settings and Help and support:
/// back arrow + page title at the top, 16px side padding, and scrolling.
///
/// Same idea as AuthPageLayout: a Spacer() inside [children] pushes the
/// following widgets to the bottom, and the page scrolls on small screens or
/// when the keyboard is open.
class AppPageLayout extends StatelessWidget {
  const AppPageLayout({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

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
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                child: Column(
                  // stretch = children take the full width (cards, buttons)
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 56.h,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            padding: EdgeInsets.zero,
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
                          SizedBox(width: 4.w),
                          Text(title, style: AppTextStyles.pageTitle),
                        ],
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