

class UserReviewsResponse {
  const UserReviewsResponse({
    required this.reviews,
    required this.page,
    required this.limit,
  });

  final List<UserReviewModel> reviews;
  final int page;
  final int limit;

  factory UserReviewsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['reviews'] as List? ?? const [];

    return UserReviewsResponse(
      reviews: list
          .map(
            (item) => UserReviewModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }
}

class UserReviewModel {
  const UserReviewModel({
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
    required this.restaurant,
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
  final UserReviewRestaurant restaurant;
  final UserReviewDish? dish;

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return UserReviewModel(
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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'].toString()),
      restaurant: UserReviewRestaurant.fromJson(
        json['restaurant'] as Map<String, dynamic>,
      ),
      dish: json['dish'] == null
          ? null
          : UserReviewDish.fromJson(
              json['dish'] as Map<String, dynamic>,
            ),
    );
  }
}

class UserReviewRestaurant {
  const UserReviewRestaurant({
    required this.id,
    required this.name,
    this.photoUrl,
  });

  final String id;
  final String name;
  final String? photoUrl;

  factory UserReviewRestaurant.fromJson(Map<String, dynamic> json) {
    return UserReviewRestaurant(
      id: json['id'].toString(),
      name: (json['name'] ?? '') as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}

class UserReviewDish {
  const UserReviewDish({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory UserReviewDish.fromJson(Map<String, dynamic> json) {
    return UserReviewDish(
      id: json['id'].toString(),
      name: (json['name'] ?? '') as String,
    );
  }
}
