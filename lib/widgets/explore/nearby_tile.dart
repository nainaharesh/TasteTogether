// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/theme/appcolors.dart';

class NearbyTile extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;

  const NearbyTile({super.key, required this.restaurant, this.onTap});

  @override
  Widget build(BuildContext context) {
    final distance = restaurant.distanceKm;
    final subtitle = distance == null
        ? restaurant.cuisine
        : '${restaurant.cuisine} · ${distance.toStringAsFixed(1)} km';
    final imageUrl = restaurant.imageUrl;

    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 12,
            children: [
              // Photo 72 x 72, radius 12
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: 72,
                  height: 72,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl == null
                      ? const ColoredBox(
<<<<<<< HEAD
                          color: AppColors.photoPlaceholder2,
                          child: Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 22,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        )
                      : Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const ColoredBox(
                            color: AppColors.photoPlaceholder2,
                            child: Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 22,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
=======
                    color: AppColors.photoPlaceholder2,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 22,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  )
                      : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: AppColors.photoPlaceholder2,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
>>>>>>> your-development
                ),
              ),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 22 / 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: AppColors.textMuted,
                        ),
                        Flexible(
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        Text(
                          restaurant.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '(${restaurant.reviewCount} reviews)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
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
<<<<<<< HEAD
}
=======
}
>>>>>>> your-development
