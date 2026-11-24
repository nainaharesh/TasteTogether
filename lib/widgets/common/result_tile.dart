// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Photo + naam + subtitle + rating wali card row.
/// Search results aur Saved places dono yehi use karte hain:
///  - badge:    "Dish" / "Restaurant" pill (sirf search mein)
///  - trailing: card ke right ka button (sirf saved mein, bookmark hatane ke liye)
class ResultTile extends StatelessWidget {
  const ResultTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.countLabel,
    required this.placeholderColor,
    required this.onTap,
    this.badge,
    this.trailing,
  });

  final String name;
  final String subtitle;
  final double rating;
  final String countLabel;
  final Color placeholderColor;
  final VoidCallback onTap;
  final String? badge;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        // trailing button ho to right padding 4 (design), warna 10
        padding: EdgeInsets.fromLTRB(
          10.r,
          10.r,
          trailing == null ? 10.r : 4.r,
          10.r,
        ),
        child: Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: onTap,
                child: Row(
                  spacing: 12.w,
                  children: [
                    Container(
                      width: 88.r,
                      height: 88.r,
                      decoration: BoxDecoration(
                        color: placeholderColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        size: 24.r,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2.h,
                        children: [
                          if (badge != null)
                            // Align: badge sirf text jitna chaudha rahe
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(minHeight: 20.h),
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.border,
                                  borderRadius: BorderRadius.circular(999.r),
                                ),
                                child: Center(
                                  widthFactor: 1,
                                  child: Text(
                                    badge!,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              height: 22 / 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              height: 18 / 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Row(
                            spacing: 4.w,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 14.r,
                                color: AppColors.primary,
                              ),
                              Text(
                                rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  countLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
