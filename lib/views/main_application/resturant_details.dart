// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/restaurant_details_viewmodel/restaurant_details_view_model.dart';
import 'package:tastetogether/widgets/common/bottom_action_bar.dart';
import 'package:tastetogether/widgets/common/hero_sheet.dart';
import 'package:tastetogether/widgets/common/outlined_wide_button.dart';
import 'package:tastetogether/widgets/common/section_header.dart';
import 'package:tastetogether/widgets/common/star_row.dart';
import 'package:tastetogether/widgets/restaurant_details/dish_tile.dart';
import 'package:tastetogether/widgets/reviews/review_card.dart';

class ResturantDetails extends StatelessWidget {
  ResturantDetails({super.key, required this.restaurant});

  final Restaurant restaurant;

  late final RestaurantDetailsViewModel controller = Get.put(
    RestaurantDetailsViewModel(restaurant),
  );

  static const _dishColors = [
    AppColors.photoPlaceholder2, // #DCC5B3
    AppColors.photoPlaceholder3, // #C9A892
    AppColors.fieldBorder, // #D2B7A3
  ];

  @override
  Widget build(BuildContext context) {
    final subtitle = restaurant.area.isEmpty
        ? restaurant.cuisine
        : '${restaurant.cuisine} · ${restaurant.area}';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(
          () => HeroSheet(
            photoLabel: restaurant.name,
            photoPrefix: 'Cover photo',
            imageUrl: restaurant.imageUrl,
            isSaved: controller.isSaved.value,
            onBack: Get.back,
            onSave: controller.toggleSave,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name, cuisine, address
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontSize: 26.sp,
                    height: 32 / 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: AppColors.textPrimary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 22 / 15,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    spacing: 6.w,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.r,
                        color: AppColors.textMuted,
                      ),
                      Expanded(
                        child: Text(
                          controller.address,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // rating
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SizedBox(
                    height: 32.h,
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Text(
                          restaurant.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        StarRow(rating: restaurant.rating, size: 16),
                        Flexible(
                          child: Text(
                            '${restaurant.reviewCount} reviews',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // about
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text(
                    controller.about,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 22 / 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                // popular dishes
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Popular dishes',
                  trailingText: 'See all',
                  onTrailingTap: () => Get.toNamed(AppRoutes.allDishes, arguments: AllDishesArgs(restaurantName: restaurant.name,
                      dishes: controller.dishes)),
                ),
                SizedBox(height: 8.h),
                // height fixed nahi: tile apne content ke hisaab se barhta hai
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // sheet ke 16 padding se bahar tak scroll ho
                  clipBehavior: Clip.none,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.w,
                    children: [
                      for (var i = 0; i < controller.dishes.length; i++)
                        DishTile(
                          dish: controller.dishes[i],
                          placeholderColor: _dishColors[i % _dishColors.length],
                          onTap: () => Get.toNamed(AppRoutes.dishDetails, arguments: controller.dishes[i]),
                        ),
                    ],
                  ),
                ),

                // reviews
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Customer reviews',
                  trailingText: '${restaurant.reviewCount}',
                ),
                SizedBox(height: 8.h),
                for (final review in controller.reviews) ...[
                  ReviewCard(review: review),
                  SizedBox(height: 12.h),
                ],
                SizedBox(height: 4.h),
                OutlinedWideButton(
                  label: 'See all ${restaurant.reviewCount} reviews',
                  onPressed: () => Get.toNamed(AppRoutes.allReviews, arguments: AllReviewsArgs(title: restaurant.name,
                      reviews: controller.reviews)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        label: 'Write a Review',
        icon: Icons.edit_outlined,
        onPressed: () =>
            Get.toNamed(AppRoutes.createReview, arguments: ReviewArgs(restaurantName: restaurant.name)),
      ),
    );
  }
}
