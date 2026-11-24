// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Outlined button (48 high): "See all 248 reviews", "Edit Profile", "Following"
/// - icon:      label se pehle chhota icon
/// - fullWidth: false ho to button sirf apne content jitna chaudha (padding 24)
class OutlinedWideButton extends StatelessWidget {
  const OutlinedWideButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.compact = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool fullWidth;

  /// Followers list wala chhota button: 104 x 44, radius 12, text 14
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.primaryDeep,
      minimumSize: compact
          ? Size(104.w, 44.h)
          : Size(fullWidth ? double.infinity : 0, 48.h),
      padding: compact
          ? EdgeInsets.zero
          : (fullWidth ? null : EdgeInsets.symmetric(horizontal: 24.w)),
      side: const BorderSide(color: AppColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(compact ? 12.r : 14.r),
      ),
    );
    final text = Text(
      label,
      style: TextStyle(
        fontSize: compact ? 14.sp : 15.sp,
        fontWeight: FontWeight.w700,
      ),
    );

    if (icon == null) {
      return OutlinedButton(onPressed: onPressed, style: style, child: text);
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: style,
      icon: Icon(icon, size: 20.r),
      label: text,
    );
  }
}
