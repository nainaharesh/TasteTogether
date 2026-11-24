import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/views/main_application/comments.dart';
import 'package:tastetogether/widgets/home_feed/post_card.dart';

=======

import 'package:tastetogether/widgets/home_feed/post_card.dart';

import '../../models/post_model.dart';

>>>>>>> your-development
class FeedList extends StatelessWidget {
  const FeedList({super.key, required this.posts});

  final RxList<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (posts.isEmpty) {
        return const Center(child: Text('No posts yet'));
      }
      return ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: posts.length,
        separatorBuilder: (_, _) => SizedBox(height: 16.h),
        itemBuilder: (_, i) {
          final p = posts[i];
          return PostCard(
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
            onComment: () => Get.to(() => Comments(post: p)),
          );
        },
      );
    });
  }
}
