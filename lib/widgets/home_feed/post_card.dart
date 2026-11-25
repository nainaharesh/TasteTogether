// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/utils/app_assets.dart';
import 'package:tastetogether/widgets/home_feed/photo_placeholder.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.username,
    required this.initials,
    required this.restaurant,
    required this.timeAgo,
    required this.dishName,
    required this.rating,
    required this.review,
    required this.likes,
    required this.comments,
    this.imageUrl,
    this.avatarColor = AppColors.primary,
    this.isLiked = false,
    this.isSaved = false,
    this.onTap,
    this.onUserTap,
    this.onMore,
    this.onLike,
    this.onComment,
    this.onSave,
  });

  final String username;
  final String initials;
  final String restaurant;
  final String timeAgo;
  final String dishName;
  final double rating;
  final String review;
  final int likes;
  final int comments;
  final String? imageUrl;
  final Color avatarColor;
  final bool isLiked;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? onUserTap; // avatar / username par tap
  final VoidCallback? onMore;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 4.w, 0),
            child: Row(
              spacing: 10.w,
              children: [
                GestureDetector(
                  onTap: onUserTap,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: avatarColor,
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onUserTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2.h,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Row(
                          spacing: 4.w,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 12.r,
                              color: AppColors.primaryDeep,
                            ),
                            Flexible(
                              child: Text(
                                restaurant,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryDeep,
                                ),
                              ),
                            ),
                            Text(
                              '· $timeAgo',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onMore,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tightFor(
                    width: 44.r,
                    height: 44.r,
                  ),
                  icon: Icon(
                    Icons.more_horiz,
                    size: 22.r,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // 2. Photo + title + review (tap = detail)
          InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: AspectRatio(
                      aspectRatio: 337 / 210,
                      child: PhotoPlaceholder(
                        label: dishName,
                        imageUrl: imageUrl,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: [
                      Row(
                        spacing: 8.w,
                        children: [
                          Expanded(
                            child: Text(
                              dishName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17.sp,
                                height: 24 / 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Stars(rating: rating),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          text: '$review ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 21 / 14,
                            color: AppColors.textPrimary,
                          ),
                          children: [
                            TextSpan(
                              text: 'more',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDeep,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Actions
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 4.h, 6.w, 6.h),
            child: Row(
              children: [
                ActionButton(
                  // liked = asset (likes.png). Unliked outline heart ka asset nahi hai.
                  icon: isLiked
                      ? Image.asset(AppAssets.likes, width: 22.r, height: 22.r)
                      : Icon(
                          Icons.favorite_border,
                          size: 22.r,
                          color: AppColors.primary,
                        ),
                  count: likes,
                  onTap: onLike,
                ),
                ActionButton(
                  icon: Image.asset(
                    AppAssets.comments,
                    width: 22.r,
                    height: 22.r,
                  ),
                  count: comments,
                  onTap: onComment,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onSave,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tightFor(
                    width: 44.r,
                    height: 44.r,
                  ),
                  // not saved = asset (flag.png). Filled bookmark ka asset nahi hai.
                  icon: isSaved
                      ? Icon(
                          Icons.bookmark,
                          size: 22.r,
                          color: AppColors.textPrimary,
                        )
                      : Image.asset(
                          AppAssets.bookmark,
                          width: 22.r,
                          height: 22.r,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Stars extends StatelessWidget {
  const Stars({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6.w,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2.w,
          children: [
            for (var i = 1; i <= 5; i++)
              Icon(
                rating >= i ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 14.r,
                color: AppColors.primary,
              ),
          ],
        ),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.count,
    this.onTap,
  });

  final Widget icon;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22.r),
      child: Padding(
        // 11 + icon 22 + 11 = 44 touch height
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6.w,
          children: [
            icon,
            Text(
              '$count',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
