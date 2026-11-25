// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/main_application_models_home_feed_viewmodel_bottomnavbar_view_model.dart';
import 'package:tastetogether/viewmodels/saved_view_model.dart';
import 'package:tastetogether/views/main_application/resturant_details.dart';
import 'package:tastetogether/views/main_application/dish_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';

import 'package:tastetogether/widgets/common/chip_row.dart';
import 'package:tastetogether/widgets/common/empty_state.dart';
import 'package:tastetogether/widgets/common/result_tile.dart';

/// Screen 11 · Saved Places (bottom navbar ka 4th tab)
class Saved extends StatelessWidget {
  Saved({super.key});

  final SavedViewModel controller = Get.put(SavedViewModel());

  static const colors = [
    AppColors.photoPlaceholder2, // #DCC5B3
    AppColors.photoPlaceholder3, // #C9A892
    AppColors.fieldBorder, // #D2B7A3
    AppColors.photoPlaceholder1, // #E2CDBD
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 16.w,
        title: Text(
          'Saved Places',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.56,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Obx(
                () => Text(
                  '${controller.places.length} saved',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Obx(
              () => ChipRow(
                labels: SavedViewModel.filters,
                selectedIndex: controller.selectedFilter.value,
                onSelected: controller.selectFilter,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final list = controller.visible;
              if (list.isEmpty && controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (list.isEmpty) {
                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: controller.fetchSaved,
                  child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: EmptyState(
                    icon: Icons.bookmark_border_rounded,
                    title: 'Nothing saved yet',
                    message: 'Tap the bookmark on any restaurant or dish and it will show up here.',
                    actionLabel: 'Explore restaurants',
                    // Explore bottom navbar ka 2nd tab hai
                    onAction: () =>
                        Get.find<BottomNavbarViewModel>().changeIndex(1),
                  ),
                  ),
                );
              }
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: controller.fetchSaved,
                child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                // har card ke neeche 12 (Padding), isliye last par 16 - 12 = 4
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final place = list[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ResultTile(
                      name: place.name,
                      subtitle: place.subtitle,
                      rating: place.rating,
                      countLabel: place.countLabel,
                      placeholderColor: colors[i % colors.length],
                      onTap: () => place.isDish
                          ? Get.to(() => DishDetails(dish: place.dish!))
                          : Get.to(
                              () => ResturantDetails(
                                restaurant: place.restaurant!,
                              ),
                            ),
                      trailing: IconButton(
                        tooltip: 'Remove from saved',
                        onPressed: () => controller.remove(place),
                        style: IconButton.styleFrom(
                          fixedSize: Size.square(44.r),
                          foregroundColor: AppColors.primary,
                        ),
                        icon: Icon(Icons.bookmark_rounded, size: 24.r),
                      ),
                    ),
                  );
                },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
