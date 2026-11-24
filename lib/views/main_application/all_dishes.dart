// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/app_back_button.dart';
import 'package:tastetogether/widgets/common/result_tile.dart';

/// Restaurant details ke "Popular dishes" ka "See all"
class AllDishes extends StatelessWidget {
  const AllDishes({
    super.key,
    required this.restaurantName,
    required this.dishes,
  });

  final String restaurantName;
  final List<Dish> dishes;

  static const _colors = [
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
        leading: const AppBackButton(),
        title: Text(
          'Popular dishes',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
        itemCount: dishes.length + 1,
        itemBuilder: (_, i) {
          if (i == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                '$restaurantName · ${dishes.length} dishes',
                style: TextStyle(fontSize: 14.sp, color: AppColors.textMuted),
              ),
            );
          }
          final dish = dishes[i - 1];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: ResultTile(
              name: dish.name,
              subtitle: dish.restaurantName,
              rating: dish.rating,
              countLabel: '(${dish.ratingCount})',
              placeholderColor: _colors[(i - 1) % _colors.length],
              onTap: () => Get.toNamed(AppRoutes.dishDetails, arguments: dish),
            ),
          );
        },
      ),
    );
  }
}
