// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/outlined_wide_button.dart';




/// Follow (filled) <-> Following (outlined) button.
/// compact: false = poori width 48 high (profile), true = 104 x 44 (followers list)
class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.isFollowing,
    required this.onPressed,
    this.compact = false,
  });

  final bool isFollowing;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (isFollowing) {
      return OutlinedWideButton(
        label: 'Following',
        icon: compact ? null : Icons.check_rounded,
        compact: compact,
        onPressed: onPressed,
      );
    }

    final style = FilledButton.styleFrom(
      minimumSize: compact ? Size(104.w, 44.h) : Size.fromHeight(48.h),
      padding: compact ? EdgeInsets.zero : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(compact ? 12.r : 14.r),
      ),
    );
    final label = Text(
      'Follow',
      style: TextStyle(
        fontSize: compact ? 14.sp : 15.sp,
        fontWeight: FontWeight.w700,
      ),
    );
    if (compact) {
      return FilledButton(onPressed: onPressed, style: style, child: label);
    }
    return FilledButton.icon(
      onPressed: onPressed,
      style: style,
      icon: Icon(Icons.person_add_alt_1_outlined, size: 20.r),
      label: label,
    );
  }
}
