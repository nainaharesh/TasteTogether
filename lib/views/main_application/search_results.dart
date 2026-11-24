// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/models/search_result_model.dart';
import 'package:tastetogether/models/search_filters_model.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/main_application_models/search_results_viewmodel/search_results_view_model.dart';
import 'package:tastetogether/widgets/common/chip_row.dart';
import 'package:tastetogether/widgets/common/result_tile.dart';
import 'package:tastetogether/widgets/search/filter_sheet.dart';
import 'package:tastetogether/widgets/search/search_input_bar.dart';

class SearchResults extends StatelessWidget {
  SearchResults({
    super.key,
    this.query = '',
    this.initialFilter = 0,
    this.filters = const SearchFilters(),
  });

  final String query;

  /// "See all" se aaye to Restaurants / Dishes / Nearby chip pehle se select
  final int initialFilter;

  /// Explore ke Filters sheet se aaye hue filters
  final SearchFilters filters;

  late final SearchResultsViewModel controller = Get.put(
    SearchResultsViewModel(
      query: query,
      initialFilter: initialFilter,
      filters: filters,
    ),
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
      Get.toNamed(AppRoutes.dishDetails, arguments: Dish(
            name: r.name,
            restaurantName: r.secondary,
            rating: r.rating,
            ratingCount: r.count,
          ));
    } else {
      Get.toNamed(AppRoutes.restaurantDetails, arguments: Restaurant(
            name: r.name,
            cuisine: r.secondary,
            area: '',
            rating: r.rating,
            reviewCount: r.count,
            distanceKm: r.distanceKm,
          ));
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
            Obx(
              () => ChipRow(
                labels: SearchResultsViewModel.filters,
                selectedIndex: controller.selectedFilter.value,
                onSelected: controller.selectFilter,
              ),
            ),

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
                    GestureDetector(
                      onTap: () async {
                        final result = await FilterSheet.show(
                          controller.appliedFilters.value,
                          sortOnly: true,
                        );
                        if (result != null) controller.applyFilters(result);
                      },
                      child: Row(
                        spacing: 4.w,
                        children: [
                          Obx(
                            () => Text(
                              SearchFilters.sortOptions[controller
                                  .appliedFilters
                                  .value
                                  .sort],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDeep,
                              ),
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
                  itemBuilder: (_, i) => ResultTile(
                    badge: list[i].isDish ? 'Dish' : 'Restaurant',
                    name: list[i].name,
                    subtitle: list[i].subtitle,
                    rating: list[i].rating,
                    countLabel: list[i].countLabel,
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
