// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/models/profile_model.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Profile ka neeche wala hissa: "My reviews" tab + 3 column photo grid.
/// Profile aur Other user's profile dono yehi use karte hain.
/// Grid khud scroll nahi karta, screen ka scroll use hota hai.
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
    super.key,
    required this.label,
    required this.reviews,
    required this.onTap,
  });

  final String label; // 'My reviews' / 'Reviews'
  final List<ProfileReview> reviews;
  final ValueChanged<ProfileReview> onTap;

  static const colors = [
    AppColors.photoPlaceholder2, // #DCC5B3
    AppColors.photoPlaceholder3, // #C9A892
    AppColors.fieldBorder, // #D2B7A3
    AppColors.photoPlaceholder1, // #E2CDBD
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // tab: sirf aik (design mein bhi aik hi hai), poori width
        Container(
          height: 44.h,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.w,
                children: [
                  Icon(
                    Icons.grid_view_rounded,
                    size: 18.r,
                    color: AppColors.textPrimary,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              // active tab ka underline
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 2,
                child: ColoredBox(color: AppColors.primary),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
          itemCount: reviews.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.h,
            crossAxisSpacing: 4.w,
            childAspectRatio: 117.67 / 114, // design: tile 117.67 x 114
          ),
          itemBuilder: (_, i) => ReviewThumb(
            review: reviews[i],
            color: colors[i % colors.length],
            onTap: () => onTap(reviews[i]),
          ),
        ),
      ],
    );
  }
}

class ReviewThumb extends StatelessWidget {
  const ReviewThumb({super.key, 
    required this.review,
    required this.color,
    required this.onTap,
  });

  final ProfileReview review;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final url = review.imageUrl;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (url == null)
              ColoredBox(color: color)
            else
              Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(color: color),
              ),
            Positioned(
              left: 6.w,
              bottom: 6.h,
              child: Container(
                constraints: BoxConstraints(minHeight: 22.h),
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 3.w,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 11.r,
                      color: AppColors.primary,
                    ),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
