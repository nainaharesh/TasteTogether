
 // ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/explore_viewmodel/explore_view_model.dart';
import 'package:tastetogether/views/main_application/resturant_details.dart';
import 'package:tastetogether/views/main_application/search_results.dart';
import 'package:tastetogether/widgets/explore/custom_serachfield.dart';
import 'package:tastetogether/widgets/explore/dish_card.dart';
import 'package:tastetogether/widgets/explore/food_category_chip.dart';
import 'package:tastetogether/widgets/explore/nearby_tile.dart';
import 'package:tastetogether/widgets/explore/resturant_card.dart';
import 'package:tastetogether/widgets/explore/section_textlabels.dart';

class Explore extends StatelessWidget {
  Explore({super.key});

  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width * 0.59;
    final tileWidth = MediaQuery.sizeOf(context).width * 0.315;

    final listHeight = cardWidth * 108 / 232 + 92;
    final tileListHeight = tileWidth * 104 / 124 + 64;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 4.w,
            right: 4.w,
            top: 24.h,
          ),
          child: Column(
            spacing: 8.h,
            children: [

              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SearchTextField(
                  hintText: 'Search restaurants or dishes',
                  onSubmitted: (value) {
                    if (value.trim().isEmpty) return;

                    Get.to(
                      () => SearchResults(query: value.trim()),
                    );
                  },
                  prefixIcon: ImageIcon(
                    const AssetImage('assets/icons/searchbar.png'),
                    size: 20.r,
                    color: AppColors.textMuted,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/filter.png',
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
              ),

              // Category chips
              Obx(() {
                final selected = controller.selectedCategory.value;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    spacing: 8.w,
                    children: [
                      for (var i = 0;
                          i < controller.categories.length;
                          i++)
                        FoodCategoryChip(
                          label: controller.categories[i],
                          isSelected: i == selected,
                          onTap: () => controller.selectCategory(i),
                        ),
                    ],
                  ),
                );
              }),

              // Popular restaurants
              Column(
                spacing: 4.h,
                children: [
                  SectionTextlabels(
                    title: 'Popular restaurants',
                    onSeeAllPressed: () {},
                  ),

                  SizedBox(
                    height: listHeight,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: controller.restaurants.length,
                        itemBuilder: (context, i) {
                          final restaurant = controller.restaurants[i];

                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: SizedBox(
                              width: cardWidth,
                              child: RestaurantCard(
                                restaurant: restaurant,
                                placeholderColor:
                                    AppColors.photoPlaceholder2,
                                onTap: () {
                                  Get.to(
                                    () => ResturantDetails(
                                      restaurant: restaurant,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Trending dishes
              Column(
                spacing: 4.h,
                children: [
                  SectionTextlabels(
                    title: 'Trending dishes',
                    onSeeAllPressed: () {},
                  ),

                  SizedBox(
                    height: tileListHeight,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: controller.dishes.length,
                        itemBuilder: (context, i) {
                          final dish = controller.dishes[i];

                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: SizedBox(
                              width: tileWidth,
                              child: DishCard(
                                dish: dish,
                                placeholderColor:
                                    AppColors.photoPlaceholder2,
                                onTap: () {
                                  Get.to(
                                    () => ResturantDetails(
                                      restaurant:
                                          controller.restaurantOfDish(dish),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Nearby restaurants
              Column(
                spacing: 4.h,
                children: [
                  SectionTextlabels(
                    title: 'Nearby',
                    onSeeAllPressed: () {},
                  ),

                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        0,
                        16.w,
                        16.h,
                      ),
                      itemCount: controller.nearby.length,
                      itemBuilder: (context, i) {
                        final restaurant = controller.nearby[i];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: NearbyTile(
                            restaurant: restaurant,
                            onTap: () {
                              Get.to(
                                () => ResturantDetails(
                                  restaurant: restaurant,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
