// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/theme/appcolors.dart';
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
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 4, 0),
            child: Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: avatarColor,
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.surface,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: AppColors.primaryDeep,
                          ),
                          Flexible(
                            child: Text(
                              restaurant,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDeep,
                              ),
                            ),
                          ),
                          Text(
                            '· $timeAgo',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onMore,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 44,
                    height: 44,
                  ),
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 22,
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
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
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
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Text(
                              dishName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
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
                          style: const TextStyle(
                            fontSize: 14,
                            height: 21 / 14,
                            color: AppColors.textPrimary,
                          ),
                          children: const [
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
            padding: const EdgeInsets.fromLTRB(8, 4, 6, 6),
            child: Row(
              children: [
                ActionButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.primary,
                  count: likes,
                  onTap: onLike,
                ),
                ActionButton(
                  icon: Icons.chat_bubble_outline,
                  color: AppColors.textPrimary,
                  count: comments,
                  onTap: onComment,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onSave,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 44,
                    height: 44,
                  ),
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: 22,
                    color: AppColors.textPrimary,
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
      spacing: 6,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            for (var i = 1; i <= 5; i++)
              Icon(
                rating >= i ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 14,
                color: AppColors.primary,
              ),
          ],
        ),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 13,
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
    required this.color,
    required this.count,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        // 11 + icon 22 + 11 = 44 touch height
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Icon(icon, size: 22, color: color),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> your-development
