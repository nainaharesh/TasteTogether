// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/theme/appcolors.dart';

class NearbyTile extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;

  const NearbyTile({super.key, required this.restaurant, this.onTap});

  @override
  Widget build(BuildContext context) {
    final distance = restaurant.distanceKm;
    final imageUrl = restaurant.imageUrl;
    final subtitle = distance == null
        ? restaurant.cuisine
        : '${restaurant.cuisine} · ${distance.toStringAsFixed(1)} km';

    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Row(
            spacing: 12.w,
            children: [
              // Photo 72 x 72, radius 12
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 72.r, height: 72.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: imageUrl == null
                      ? placeholder()
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => placeholder(),
                        ),
                ),
              ),

              // Details
              Expanded(
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
                    Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 13.r,
                          color: AppColors.textMuted,
                        ),
                        Flexible(
                          child: Text(
                            subtitle,
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
                    Row(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget placeholder() {
    return ColoredBox(
      color: AppColors.photoPlaceholder2,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 22.r,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
