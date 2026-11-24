// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/search_filters_model.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/explore_viewmodel/explore_view_model.dart';
import 'package:tastetogether/widgets/search/filter_sheet.dart';
import 'package:tastetogether/widgets/common/chip_row.dart';
import 'package:tastetogether/widgets/explore/custom_serachfield.dart';
import 'package:tastetogether/widgets/explore/dish_card.dart';
import 'package:tastetogether/widgets/explore/nearby_tile.dart';
import 'package:tastetogether/widgets/explore/resturant_card.dart';
import 'package:tastetogether/widgets/explore/section_textlabels.dart';

class Explore extends StatelessWidget {
  Explore({super.key});

  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    // card ki width screen ke fraction se (232/393, 124/393).
    // Height ab kahin fixed nahi: card apne content ke hisaab se khud barhta hai
    final cardWidth = MediaQuery.sizeOf(context).width * 0.59;
    final tileWidth = MediaQuery.sizeOf(context).width * 0.315;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 24.h),
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
                    Get.toNamed(AppRoutes.searchResults, arguments: SearchArgs(query: value.trim()));
                  },
                  prefixIcon: ImageIcon(
                    const AssetImage('assets/icons/searchbar.png'),
                    size: 20.r,
                    color: AppColors.textMuted,
                  ),
                  suffixIcon: GestureDetector(
                    // Filters sheet -> Apply par filtered Search Results khulte hain
                    onTap: () async {
                      final filters = await FilterSheet.show(
                        const SearchFilters(),
                      );
                      if (filters != null) {
                        Get.toNamed(AppRoutes.searchResults, arguments: SearchArgs(filters: filters));
                      }
                    },
                    child: Image.asset(
                      'assets/icons/filter.png',
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
              ),

              // Category chips
              Obx(
                () => ChipRow(
                  labels: controller.categories,
                  selectedIndex: controller.selectedCategory.value,
                  onSelected: controller.selectCategory,
                ),
              ),

              // Popular restaurants
              Column(
                spacing: 4.h,
                children: [
                  SectionTextlabels(
                    title: 'Popular restaurants',
                    onSeeAllPressed: () =>
                        Get.toNamed(AppRoutes.searchResults, arguments: SearchArgs(initialFilter: 2)),
                  ),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.w,
                        children: [
                          for (final restaurant in controller.restaurants)
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                width: cardWidth,
                              ),
                              child: RestaurantCard(
                                restaurant: restaurant,
                                placeholderColor: AppColors.photoPlaceholder2,
                                onTap: () => Get.toNamed(AppRoutes.restaurantDetails, arguments: restaurant),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //////// Trending dishes//////
              Column(
                spacing: 4.h,
                children: [
                  SectionTextlabels(
                    title: 'Trending dishes',
                    onSeeAllPressed: () =>
                        Get.toNamed(AppRoutes.searchResults, arguments: SearchArgs(initialFilter: 1)),
                  ),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.w,
                        children: [
                          for (final dish in controller.dishes)
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                width: tileWidth,
                              ),
                              child: DishCard(
                                dish: dish,
                                placeholderColor: AppColors.photoPlaceholder2,
                                onTap: () => Get.toNamed(AppRoutes.restaurantDetails, arguments: controller.restaurantOfDish(
                                      dish,
                                    )),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              ///////Nearby ///////
              Column(
                spacing: 4.h,
                children: [
                  SectionTextlabels(
                    title: 'Nearby',
                    onSeeAllPressed: () =>
                        Get.toNamed(AppRoutes.searchResults, arguments: SearchArgs(initialFilter: 3)),
                  ),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                      itemCount: controller.nearby.length,
                      itemBuilder: (context, i) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: NearbyTile(
                          restaurant: controller.nearby[i],
                          onTap: () => Get.toNamed(AppRoutes.restaurantDetails, arguments: controller.nearby[i]),
                        ),
                      ),
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
