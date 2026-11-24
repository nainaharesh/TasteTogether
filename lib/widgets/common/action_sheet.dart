// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';

class SheetAction {
  const SheetAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// Report / Block jaisi actions laal-si (primaryDeep) dikhti hain
  final bool destructive;
}

/// Neeche se aane wali options ki list (post ka "...", profile ka "...")
class ActionSheet extends StatelessWidget {
  const ActionSheet({super.key, required this.actions});

  final List<SheetAction> actions;

  static Future<void> show(List<SheetAction> actions) {
    return Get.bottomSheet(
      ActionSheet(actions: actions),
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // upar ka chhota handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                children: [
                  for (final a in actions)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minTileHeight: 52.h,
                      leading: Icon(
                        a.icon,
                        size: 22.r,
                        color: a.destructive
                            ? AppColors.primaryDeep
                            : AppColors.textPrimary,
                      ),
                      title: Text(
                        a.label,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: a.destructive
                              ? AppColors.primaryDeep
                              : AppColors.textPrimary,
                        ),
                      ),
                      onTap: () {
                        Get.back(); // pehle sheet band, phir action
                        a.onTap();
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
