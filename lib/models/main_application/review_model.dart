// ignore_for_file: deprecated_member_use

/// Ek review. Home feed aur Restaurant ke reviews dono ka shape yehi hai.
/// `restaurant` sirf Home feed mein aata hai, `dish` sirf tab jab review kisi
/// dish ka ho. Dono na hon to null.
class Review {
  const Review({
    required this.id,
    required this.userId,
    required this.restaurantId,
    this.dishId,
    required this.rating,
    required this.text,
    this.photoUrl,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    this.createdAt,
    required this.author,
    this.restaurant,
    this.dish,
  });

  final String id;
  final String userId;
  final String restaurantId;
  final String? dishId;
  final double rating;
  final String text;
  final String? photoUrl;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final DateTime? createdAt;
  final Author author;
  final ReviewRestaurant? restaurant;
  final ReviewDish? dish;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'].toString(),
      userId: (json['userId'] ?? '').toString(),
      restaurantId: (json['restaurantId'] ?? '').toString(),
      dishId: json['dishId']?.toString(),
      rating: ((json['rating'] ?? 0) as num).toDouble(),
      text: (json['text'] ?? '') as String,
      photoUrl: json['photoUrl'] as String?,
      likeCount: ((json['likeCount'] ?? 0) as num).toInt(),
      commentCount: ((json['commentCount'] ?? 0) as num).toInt(),
      isLiked: (json['isLiked'] ?? false) as bool,
      createdAt: DateTime.tryParse('${json['createdAt']}'),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      restaurant: json['restaurant'] == null
          ? null
          : ReviewRestaurant.fromJson(
              json['restaurant'] as Map<String, dynamic>,
            ),
      dish: json['dish'] == null
          ? null
          : ReviewDish.fromJson(json['dish'] as Map<String, dynamic>),
    );
  }
}

class Author {
  const Author({
    required this.id,
    required this.fullName,
    required this.username,
    this.avatarUrl,
    this.avatarColor,
  });

  final String id;
  final String fullName;
  final String username;
  final String? avatarUrl;

  /// hex jaise "#D97757"
  final String? avatarColor;

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'].toString(),
      fullName: (json['fullName'] ?? '') as String,
      username: (json['username'] ?? '') as String,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
    );
  }
}

/// Review ke andar ka chhota restaurant (sirf id, name, photoUrl).
class ReviewRestaurant {
  const ReviewRestaurant({
    required this.id,
    required this.name,
    this.photoUrl,
  });

  final String id;
  final String name;
  final String? photoUrl;

  factory ReviewRestaurant.fromJson(Map<String, dynamic> json) {
    return ReviewRestaurant(
      id: json['id'].toString(),
      name: (json['name'] ?? '') as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}

/// Review ke andar ki chhoti dish (sirf id, name).
class ReviewDish {
  const ReviewDish({required this.id, required this.name});

  final String id;
  final String name;

  factory ReviewDish.fromJson(Map<String, dynamic> json) {
    return ReviewDish(
      id: json['id'].toString(),
      name: (json['name'] ?? '') as String,
    );
  }
}

/// GET /api/restaurants/{id}/reviews?page=&limit=
/// Response: { reviews: [...], page, limit }
class ReviewListModel {
  const ReviewListModel({
    required this.reviews,
    required this.page,
    required this.limit,
  });

  final List<Review> reviews;
  final int page;
  final int limit;

  factory ReviewListModel.fromJson(Map<String, dynamic> json) {
    final list = json['reviews'] as List? ?? const [];
    return ReviewListModel(
      reviews: list
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }
}