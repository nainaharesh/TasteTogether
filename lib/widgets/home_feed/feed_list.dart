import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/post_models.dart';
import 'package:tastetogether/widgets/home_feed/post_card.dart';

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
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
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
          );
        },
      );
    });
  }
}