// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Initials wala gol avatar. style: 0 = sand, 1 = terracotta, 2 = charcoal
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.fontSize = 14,
    this.style = 0,
  });

  final String initials;
  final double size;
  final double fontSize;
  final int style;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (style) {
      1 => (AppColors.primary, AppColors.surface),
      2 => (AppColors.textPrimary, AppColors.surface),
      _ => (AppColors.border, AppColors.textPrimary),
    };

    return Container(
      width: size.r,
      height: size.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}
