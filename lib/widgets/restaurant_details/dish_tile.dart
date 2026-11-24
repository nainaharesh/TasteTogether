// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/home_feed/photo_placeholder.dart';

/// Restaurant Details ke "Popular dishes" ka card (148 wide, photo 112)
class DishTile extends StatelessWidget {
  const DishTile({
    super.key,
    required this.dish,
    required this.placeholderColor,
    this.onTap,
  });

  final Dish dish;
  final Color placeholderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // width screen ke fraction se (148 / 393), height content se
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: MediaQuery.sizeOf(context).width * 148 / 393,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AspectRatio photo ko poori width deta hai (pehle photo sirf
            // "Photo" text jitni patli rah jati thi)
            AspectRatio(
              aspectRatio: 148 / 112,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: PhotoPlaceholder(
                  imageUrl: dish.imageUrl,
                  placeholderColor: placeholderColor,
                  iconSize: 22,
                  spacing: 4,
                  fontSize: 10,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                dish.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.sp,
                  height: 20 / 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Row(
                spacing: 4.w,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 13.r,
                    color: AppColors.primary,
                  ),
                  Text(
                    dish.rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '(${dish.ratingCount})',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textMuted,
                    ),
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
