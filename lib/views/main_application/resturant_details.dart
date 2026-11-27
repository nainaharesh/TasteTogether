// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/main_application/restaurant_details_view_model.dart';
//import 'package:tastetogether/viewmodels/restaurant_details_view_model.dart';
import 'package:tastetogether/views/main_application/all_dishes.dart';
import 'package:tastetogether/views/main_application/create_review.dart';
import 'package:tastetogether/views/main_application/dish_details.dart';
import 'package:tastetogether/views/main_application/all_reviews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/main_application/resturant_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
//import 'package:tastetogether/viewmodels/main_application_models/restaurant_details_viewmodel/restaurant_details_view_model.dart';
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

  static const dishColors = [
    AppColors.photoPlaceholder2, // #DCC5B3
    AppColors.photoPlaceholder3, // #C9A892
    AppColors.fieldBorder, // #D2B7A3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Obx(() {
          // pehle pichli screen ka data, API aane par poora data
          final r = controller.restaurant.value;
          final subtitle = r.area.isEmpty ? r.cuisine : '${r.cuisine} · ${r.area}';

          return HeroSheet(
            photoLabel: r.name,
            photoPrefix: 'Cover photo',
            imageUrl: r.imageUrl,
            isSaved: controller.isSaved.value,
            onBack: Get.back,
            onSave: controller.toggleSave,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name, cuisine, address
                Text(
                  r.name,
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
                if (controller.address.isNotEmpty)
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
                          r.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        StarRow(rating: r.rating, size: 16),
                        Flexible(
                          child: Text(
                            '${r.reviewCount} reviews',
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
                if (controller.about.isNotEmpty)
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
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: SectionHeader(
                    title: 'Popular dishes',
                    trailingText: 'See all',
                    onTrailingTap: () => Get.to(
                      () => AllDishes(
                        restaurantName: r.name,
                        dishes: controller.dishes,
                      ),
                    ),
                  ),
                ),
                /*SPACER*/
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
                          placeholderColor: dishColors[i % dishColors.length],
                          onTap: () => Get.to(
                            () => DishDetails(dish: controller.dishes[i]),
                          ),
                        ),
                    ],
                  ),
                ),

                // reviews
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: SectionHeader(
                    title: 'Customer reviews',
                    trailingText: '${r.reviewCount}',
                  ),
                ),
                /*SPACER*/ for (final review in controller.reviews)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ReviewCard(review: review),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: OutlinedWideButton(
                    label: 'See all ${r.reviewCount} reviews',
                    onPressed: () => Get.to(
                      () => AllReviews(
                        title: r.name,
                        reviews: controller.reviews,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomActionBar(
        label: 'Write a Review',
        icon: Icons.edit_outlined,
        onPressed: () =>
            Get.to(() => CreateReview(restaurantName: controller.restaurant.value.name)),
      ),
    );
  }
}
