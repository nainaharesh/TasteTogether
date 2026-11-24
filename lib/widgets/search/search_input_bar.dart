// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Back arrow + orange border wala search box + clear (X) button
class SearchInputBar extends StatelessWidget {
  const SearchInputBar({
    super.key,
    required this.controller,
    required this.onBack,
    required this.onClear,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onBack;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 0, 16.w, 0),
        child: Row(
          spacing: 4.w,
          children: [
            IconButton(
              onPressed: onBack,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tightFor(width: 44.r, height: 44.r),
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 24.r,
                color: AppColors.textPrimary,
              ),
            ),
            Expanded(
              child: Container(
                height: 48.h,
                padding: EdgeInsets.only(left: 14.w, right: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Row(
                  spacing: 8.w,
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 20.r,
                      color: AppColors.textMuted,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        autofocus: controller.text.isEmpty,
                        textInputAction: TextInputAction.search,
                        onSubmitted: onSubmitted,
                        cursorColor: AppColors.primary,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search restaurants or dishes',
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textMuted,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onClear,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints.tightFor(
                        width: 40.r,
                        height: 40.r,
                      ),
                      icon: Icon(
                        Icons.close,
                        size: 18.r,
                        color: AppColors.textMuted,
                      ),
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
