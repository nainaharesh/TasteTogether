// ignore_for_file: deprecated_member_use
import 'package:tastetogether/utils/helpers.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';

/// Create Review screen se jo data API ko jayega
class NewReview {
  final String restaurantName;
  final String dishName;
  final int rating;
  final String review;
  final int photoCount;

  const NewReview({
    required this.restaurantName,
    required this.dishName,
    required this.rating,
    required this.review,
    this.photoCount = 0,
  });

  ////  later on API use here ////
  // TODO: restaurantName ki jagah restaurantId bheji jayegi, photos multipart me
  Map<String, dynamic> toJson() => {
    'restaurant_name': restaurantName,
    'dish_name': dishName,
    'rating': rating,
    'review': review,
  };
}

/// Restaurant / Dish details par dikhne wala customer review
class Review {
  final String id;
  final String username;
  final String initials;
  final String date;
  final int rating;
  final String text;

  /// 0 = sand, 1 = terracotta, 2 = charcoal (avatar ka rang)
  final int avatarStyle;

  /// photo ho to uska label (abhi placeholder), null = photo nahi
  final String? photoLabel;

  // API se aane wali extra cheezein
  final String? avatarColor; // "#C96E5E", null ho to avatarStyle chalta hai
  final String? photoUrl;

  const Review({
    required this.id,
    required this.username,
    required this.initials,
    required this.date,
    required this.rating,
    required this.text,
    this.avatarStyle = 0,
    this.photoLabel,
    this.avatarColor,
    this.photoUrl,
  });

  /// Restaurant reviews API ka ek review:
  /// { id, rating, text, photoUrl, createdAt, author{fullName, username, avatarColor}, ... }
  factory Review.fromJson(Map<String, dynamic> json) {
    final author = (json['author'] as Map?)?.cast<String, dynamic>() ?? {};
    final fullName = (author['fullName'] ?? '') as String;
    final username = (author['username'] ?? '') as String;

    return Review(
      id: json['id'].toString(),
      username: username,
      initials: UserAvatar.initialsOf(fullName.isNotEmpty ? fullName : username),
      date: formatDate(json['createdAt'] as String?),
      rating: ((json['rating'] ?? 0) as num).toInt(),
      text: (json['text'] ?? '') as String,
      avatarColor: author['avatarColor'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}

const List<Review> dummyDishReviews = [
  Review(
    id: 'd1',
    username: 'mei.tanaka',
    initials: 'MT',
    date: '9 Nov 2026',
    rating: 5,
    avatarStyle: 2,
    text: 'Rich, savoury broth with a proper hit of corn butter. The noodles had real bite.',
  ),
  Review(
    id: 'd2',
    username: 'priya.n',
    initials: 'PN',
    date: '2 Nov 2026',
    rating: 4,
    text: "Great depth in the miso. I'd ask for the egg extra soft next time.",
  ),
  Review(
    id: 'd3',
    username: 'omar.s',
    initials: 'OS',
    date: '27 Oct 2026',
    rating: 5,
    avatarStyle: 1,
    text: 'Best bowl within walking distance. Go early, the queue builds by 7.',
  ),
];
