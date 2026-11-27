// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

import 'outlined_wide_button.dart';


/// "Nothing saved yet" jaisi khali screen: gol icon + title + message + button
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40.w, 96.h, 40.w, 0),
      child: Column(
        children: [
          Container(
            width: 96.r,
            height: 96.r,
            decoration: const BoxDecoration(
              color: AppColors.border,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40.r, color: AppColors.textPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                height: 26 / 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                height: 22 / 15,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: OutlinedWideButton(
              label: actionLabel,
              fullWidth: false,
              onPressed: onAction,
            ),
          ),
        ],
      ),
    );
  }
}
