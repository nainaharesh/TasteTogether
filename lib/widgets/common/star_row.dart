// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// 5 stars ki row: bhare hue primary, khali C9A892 outline (design ke mutabiq)
class StarRow extends StatelessWidget {
  const StarRow({super.key, required this.rating, this.size = 14});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 2.w,
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            rating >= i - 0.25
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            size: size.r,
            color: rating >= i - 0.25
                ? AppColors.primary
                : AppColors.photoPlaceholder3,
          ),
      ],
    );
  }
}
