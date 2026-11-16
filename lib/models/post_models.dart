class Post {
  final String id;
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
  final bool isLiked;
  final bool isSaved;

  const Post({
    required this.id,
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
    this.isLiked = false,
    this.isSaved = false,
  });
}