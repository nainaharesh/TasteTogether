// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/models/profile_model.dart';
import 'package:tastetogether/routes/app_routes.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/action_sheet.dart';
import 'package:tastetogether/widgets/home_feed/post_card.dart';

class FeedList extends StatelessWidget {
  const FeedList({
    super.key,
    required this.posts,
    required this.onLike,
    required this.onSave,
    required this.onRefresh,
    required this.emptyState,
  });

  final RxList<Post> posts;
  final ValueChanged<String> onLike; // post id
  final ValueChanged<String> onSave; // post id
  final Future<void> Function() onRefresh;

  /// list khali ho to ye dikhta hai
  final Widget emptyState;

  void _openProfile(Post p) {
    // TODO: p.username se us user ka profile API se laana
    Get.toNamed(AppRoutes.publicProfile, arguments: dummyPublicProfile);
  }

  void _openOptions(Post p) {
    ActionSheet.show([
      SheetAction(
        icon: p.isSaved
            ? Icons.bookmark_rounded
            : Icons.bookmark_border_rounded,
        label: p.isSaved ? 'Unsave post' : 'Save post',
        onTap: () => onSave(p.id),
      ),
      SheetAction(
        icon: Icons.person_outline_rounded,
        label: 'View ${p.username}',
        onTap: () => _openProfile(p),
      ),
      SheetAction(
        icon: Icons.link_rounded,
        label: 'Copy link',
        onTap: () {
          // TODO: asli deep link jab backend ready ho
          Clipboard.setData(
            ClipboardData(text: 'https://tastetogether.app/post/${p.id}'),
          );
          Get.snackbar('Link copied', 'Post ka link copy ho gaya.');
        },
      ),
      SheetAction(
        icon: Icons.flag_outlined,
        label: 'Report post',
        destructive: true,
        // TODO: API - report
        onTap: () =>
            Get.snackbar('Reported', 'Thanks, we will review this post.'),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (posts.isEmpty) {
        return SingleChildScrollView(child: emptyState);
      }
      return RefreshIndicator(
        color: AppColors.primary,
        onRefresh: onRefresh,
        child: ListView.builder(
          // list chhoti ho tab bhi pull-to-refresh chale
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          itemCount: posts.length,
          itemBuilder: (_, i) {
            final p = posts[i];
            // cards ke beech 16 gap, last card ke baad nahi
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == posts.length - 1 ? 0 : 16.h,
              ),
              child: PostCard(
                key: ValueKey(p.id),
                username: p.username,
                initials: p.initials,
                restaurant: p.restaurant,
                timeAgo: p.timeAgo,
                dishName: p.dishName,
                rating: p.rating,
                review: p.review,
                likes: p.likes,
                comments: p.comments,
                imageUrl: p.imageUrl,
                isLiked: p.isLiked,
                isSaved: p.isSaved,
                onTap: () => Get.toNamed(AppRoutes.comments, arguments: p),
                onUserTap: () => _openProfile(p),
                onMore: () => _openOptions(p),
                onLike: () => onLike(p.id),
                onSave: () => onSave(p.id),
                onComment: () => Get.toNamed(AppRoutes.comments, arguments: p),
              ),
            );
          },
        ),
      );
    });
  }
}
