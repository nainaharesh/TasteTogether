// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    this.isScrollable = true,
  });

  final List<String> tabs;
  final TabController controller;

  /// false ho to saare tabs barabar chaude (Followers / Following)
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      tabAlignment: isScrollable ? TabAlignment.start : null,
      padding: isScrollable ? EdgeInsets.only(left: 4.w) : null,
      labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      dividerColor: AppColors.border,
      dividerHeight: 1,
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textMuted,
      labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      splashFactory: NoSplash.splashFactory,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      tabs: [for (final t in tabs) Tab(text: t, height: 44.h)],
    );
  }
}
