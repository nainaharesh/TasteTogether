// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/main_application/review_model.dart';


import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/app_back_button.dart';
import 'package:tastetogether/widgets/reviews/review_card.dart';

/// "See all N reviews" (Restaurant details aur Dish details dono se)
class AllReviews extends StatelessWidget {
  const AllReviews({super.key, required this.title, required this.reviews});

  /// restaurant ya dish ka naam
  final String title;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        leading: const AppBackButton(),
        title: Text(
          'Reviews',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      // TODO: API aane par pagination (scroll par agle reviews)
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        itemCount: reviews.length + 1,
        itemBuilder: (_, i) {
          if (i == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                '$title · ${reviews.length} reviews',
                style: TextStyle(fontSize: 14.sp, color: AppColors.textMuted),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: ReviewCard(review: reviews[i - 1]),
          );
        },
      ),
    );
  }
}
