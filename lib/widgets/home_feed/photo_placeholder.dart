// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

class PhotoPlaceholder extends StatelessWidget {
  const PhotoPlaceholder({
    super.key,
    this.label,
    this.labelPrefix = 'Photo',
    this.imageUrl,
    this.placeholderColor = AppColors.photoPlaceholder2, // #DCC5B3
    this.iconSize = 28,
    this.spacing = 6,
    this.fontSize = 11,
  });

  final String? label; // null ho to sirf prefix likha aata hai
  final String labelPrefix; // e.g. 'Photo', 'Cover photo', 'Dish photo'
  final String? imageUrl;
  final Color placeholderColor;
  final double iconSize;
  final double spacing;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null) return photoHolder();

    return Image.network(
      url,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => photoHolder(),
    );
  }

  Widget photoHolder() {
    final text = label == null ? labelPrefix : '$labelPrefix · $label';
    return Container(
      color: placeholderColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spacing.h,
        children: [
          Icon(
            Icons.image_outlined,
            size: iconSize.r,
            color: AppColors.textPrimary,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
