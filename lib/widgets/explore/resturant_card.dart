// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/home_feed/photo_placeholder.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Color placeholderColor;
  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.placeholderColor = AppColors.photoPlaceholder2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 232 / 108,
              child: PhotoPlaceholder(
                label: restaurant.name,
                imageUrl: restaurant.imageUrl,
                placeholderColor: placeholderColor,
                iconSize: 24,
                spacing: 4,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text(
                    restaurant.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 22 / 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${restaurant.cuisine} · ${restaurant.area}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      height: 18 / 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 14.r,
                          color: AppColors.primary,
                        ),
                        Text(
                          restaurant.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '(${restaurant.reviewCount} reviews)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
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
