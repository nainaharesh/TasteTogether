// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/models/search_result_model.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/search_results_viewmodel/search_results_view_model.dart';
import 'package:tastetogether/views/main_application/dish_details.dart';
import 'package:tastetogether/views/main_application/resturant_details.dart';
import 'package:tastetogether/widgets/explore/food_category_chip.dart';
import 'package:tastetogether/widgets/search/search_input_bar.dart';
import 'package:tastetogether/widgets/search/search_result_tile.dart';

class SearchResults extends StatelessWidget {
  SearchResults({super.key, this.query = ''});

  final String query;

  late final SearchResultsViewModel controller = Get.put(
    SearchResultsViewModel(query: query),
  );

  static const _colors = [
    AppColors.fieldBorder, // #D2B7A3
    AppColors.photoPlaceholder3, // #C9A892
    AppColors.photoPlaceholder2, // #DCC5B3
    AppColors.photoPlaceholder1, // #E2CDBD
  ];

  void _open(SearchResult r) {
    if (r.isDish) {
      // TODO: API aane par dish id se details fetch hongi
      Get.to(
        () => DishDetails(
          dish: Dish(
            name: r.name,
            restaurantName: r.secondary,
            rating: r.rating,
            ratingCount: r.count,
          ),
        ),
      );
    } else {
      Get.to(
        () => ResturantDetails(
          restaurant: Restaurant(
            name: r.name,
            cuisine: r.secondary,
            area: '',
            rating: r.rating,
            reviewCount: r.count,
            distanceKm: r.distanceKm,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SearchInputBar(
              controller: controller.queryController,
              onBack: Get.back,
              onClear: controller.clearQuery,
              onSubmitted: (_) => controller.search(),
            ),

            // filter chips
            Obx(() {
              final selected = controller.selectedFilter.value;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  spacing: 8.w,
                  children: [
                    for (
                      var i = 0;
                      i < SearchResultsViewModel.filters.length;
                      i++
                    )
                      FoodCategoryChip(
                        label: SearchResultsViewModel.filters[i],
                        isSelected: i == selected,
                        onTap: () => controller.selectFilter(i),
                      ),
                  ],
                ),
              );
            }),

            // count + sort
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
              child: SizedBox(
                height: 36.h,
                child: Row(
                  spacing: 12.w,
                  children: [
                    // lamba query aaye to ... lag jaye, Row phate nahi
                    Expanded(
                      child: Obx(
                        () => Text(
                          '${controller.filtered.length} results for "${controller.query.value}"',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                    // TODO: sort options (Best match / Top rated / Nearest)
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        spacing: 4.w,
                        children: [
                          Text(
                            'Best match',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryDeep,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16.r,
                            color: AppColors.primaryDeep,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // results
            Expanded(
              child: Obx(() {
                final list = controller.filtered;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (_, i) => SearchResultTile(
                    result: list[i],
                    placeholderColor: _colors[i % _colors.length],
                    onTap: () => _open(list[i]),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
