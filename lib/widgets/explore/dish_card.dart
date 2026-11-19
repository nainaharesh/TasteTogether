// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/home_feed/photo_placeholder.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  final Color placeholderColor;
  final VoidCallback? onTap;

  const DishCard({
    super.key,
    required this.dish,
    this.placeholderColor = AppColors.photoPlaceholder2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo (124 : 104, radius 14)
          AspectRatio(
            aspectRatio: 124 / 104,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: PhotoPlaceholder(
                imageUrl: dish.imageUrl,
                placeholderColor: placeholderColor,
                iconSize: 22,
                spacing: 4,
                fontSize: 10,
              ),
            ),
          ),


          // Dish ka naam (photo ke baad 6)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              dish.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Restaurant ka naam
          Text(
            dish.restaurantName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              height: 16 / 12,
              color: AppColors.textMuted,
            ),
          ),

          // Rating (upar 2)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              spacing: 3,
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 12,
                  color: AppColors.primary,
                ),
                Text(
                  dish.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

