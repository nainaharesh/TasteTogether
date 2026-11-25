// ignore_for_file: deprecated_member_use
import 'package:tastetogether/utils/helpers.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';

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

  // API se aane wali extra cheezein (dummy data mein nahi hoti)
  final String userId;
  final String restaurantId;
  final String? dishId;
  final String? avatarColor; // "#C96E5E"

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
    this.userId = '',
    this.restaurantId = '',
    this.dishId,
    this.avatarColor,
  });

  /// Feed API ka ek review:
  /// { id, userId, restaurantId, dishId, rating, text, photoUrl, likeCount,
  ///   commentCount, isLiked, createdAt, author{}, restaurant{}, dish{} }
  /// dish null ho sakti hai (sirf restaurant ka review): tab title mein restaurant ka naam.
  factory Post.fromJson(Map<String, dynamic> json) {
    final author = (json['author'] as Map?)?.cast<String, dynamic>() ?? {};
    final restaurant =
        (json['restaurant'] as Map?)?.cast<String, dynamic>() ?? {};
    final dish = (json['dish'] as Map?)?.cast<String, dynamic>();

    final fullName = (author['fullName'] ?? '') as String;
    final username = (author['username'] ?? '') as String;
    final restaurantName = (restaurant['name'] ?? '') as String;

    return Post(
      id: json['id'].toString(),
      userId: (json['userId'] ?? '').toString(),
      restaurantId: (json['restaurantId'] ?? '').toString(),
      dishId: json['dishId']?.toString(),
      username: username,
      initials: UserAvatar.initialsOf(fullName.isNotEmpty ? fullName : username),
      avatarColor: author['avatarColor'] as String?,
      restaurant: restaurantName,
      timeAgo: formatTimeAgo(json['createdAt'] as String?),
      dishName: (dish?['name'] ?? restaurantName) as String,
      rating: ((json['rating'] ?? 0) as num).toDouble(),
      review: (json['text'] ?? '') as String,
      likes: ((json['likeCount'] ?? 0) as num).toInt(),
      comments: ((json['commentCount'] ?? 0) as num).toInt(),
      imageUrl: json['photoUrl'] as String?,
      isLiked: (json['isLiked'] ?? false) as bool,
    );
  }

  Post copyWith({bool? isLiked, bool? isSaved, int? likes}) => Post(
    id: id,
    username: username,
    initials: initials,
    restaurant: restaurant,
    timeAgo: timeAgo,
    dishName: dishName,
    rating: rating,
    review: review,
    likes: likes ?? this.likes,
    comments: comments,
    imageUrl: imageUrl,
    isLiked: isLiked ?? this.isLiked,
    isSaved: isSaved ?? this.isSaved,
    userId: userId,
    restaurantId: restaurantId,
    dishId: dishId,
    avatarColor: avatarColor,
  );
}
