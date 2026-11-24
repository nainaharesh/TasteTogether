// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/dish_details_viewmodel/dish_details_view_model.dart';
import 'package:tastetogether/widgets/common/bottom_action_bar.dart';
import 'package:tastetogether/widgets/common/hero_sheet.dart';
import 'package:tastetogether/widgets/common/outlined_wide_button.dart';
import 'package:tastetogether/widgets/common/section_header.dart';
import 'package:tastetogether/widgets/dish_details/rating_summary_card.dart';
import 'package:tastetogether/widgets/reviews/review_card.dart';

class DishDetails extends StatelessWidget {
  DishDetails({super.key, required this.dish});

  final Dish dish;

  late final DishDetailsViewModel controller = Get.put(
    DishDetailsViewModel(dish),
  );

  @override
  Widget build(BuildContext context) {
    final restaurant = controller.restaurant;
    final distance = restaurant.distanceKm?.toStringAsFixed(1);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(
          () => HeroSheet(
            photoLabel: dish.name,
            photoPrefix: 'Dish photo',
            imageUrl: dish.imageUrl,
            isSaved: controller.isSaved.value,
            onBack: Get.back,
            onSave: controller.toggleSave,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: TextStyle(
                    fontSize: 26.sp,
                    height: 32 / 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: AppColors.textPrimary,
                  ),
                ),

                // restaurant card
                SizedBox(height: 12.h),
                Material(
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () =>
                        Get.toNamed(AppRoutes.restaurantDetails, arguments: restaurant),
                    child: Container(
                      height: 64.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        spacing: 12.w,
                        children: [
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: AppColors.photoPlaceholder3,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 1.h,
                              children: [
                                Text(
                                  restaurant.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.sp,
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
                                    Text(
                                      distance == null
                                          ? restaurant.cuisine
                                          : '${restaurant.cuisine} · $distance km',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20.r,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // rating summary
                SizedBox(height: 16.h),
                RatingSummaryCard(
                  rating: dish.rating,
                  ratingCount: dish.ratingCount,
                  share: controller.ratingShare,
                ),

                // reviews
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Reviews of this dish',
                  trailingText: '${dish.ratingCount}',
                ),
                SizedBox(height: 8.h),
                for (final review in controller.reviews) ...[
                  ReviewCard(review: review),
                  SizedBox(height: 12.h),
                ],
                SizedBox(height: 4.h),
                OutlinedWideButton(
                  label: 'See all ${dish.ratingCount} reviews',
                  onPressed: () => Get.toNamed(AppRoutes.allReviews, arguments: AllReviewsArgs(title: dish.name,
                      reviews: controller.reviews)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        label: 'Rate this dish',
        icon: Icons.edit_outlined,
        onPressed: () => Get.toNamed(AppRoutes.createReview, arguments: ReviewArgs(restaurantName: dish.restaurantName,
            dishName: dish.name)),
      ),
    );
  }
}
