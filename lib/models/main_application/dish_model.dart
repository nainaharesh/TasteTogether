// ignore_for_file: deprecated_member_use

/// Ek dish. Explore, Search, Saved aur Restaurants (get / dishes) sab ka
/// shape yehi hai. `restaurantName` Explore / Search mein aata hai, restaurant
/// ke apne dishes mein nahi aata (tab khali string).
class Dish {
  const Dish({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.photoUrl,
    required this.priceCents,
    required this.avgRating,
    required this.reviewCount,
    required this.isSaved,
    required this.restaurantName,
    this.createdAt,
  });

  final String id;
  final String restaurantId;
  final String name;
  final String? photoUrl;
  final int priceCents;
  final double avgRating;
  final int reviewCount;
  final bool isSaved;
  final String restaurantName;
  final DateTime? createdAt;

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'].toString(),
      restaurantId: (json['restaurantId'] ?? '').toString(),
      name: (json['name'] ?? '') as String,
      photoUrl: json['photoUrl'] as String?,
      priceCents: ((json['priceCents'] ?? 0) as num).toInt(),
      avgRating: ((json['avgRating'] ?? 0) as num).toDouble(),
      reviewCount: ((json['reviewCount'] ?? 0) as num).toInt(),
      isSaved: (json['isSaved'] ?? false) as bool,
      restaurantName: (json['restaurantName'] ?? '') as String,
      createdAt: DateTime.tryParse('${json['createdAt']}'),
    );
  }
}

/// GET /api/restaurants/{id}/dishes?page=&limit=
/// Response: { dishes: [...], page, limit }
class DishListModel {
  const DishListModel({
    required this.dishes,
    required this.page,
    required this.limit,
  });

  final List<Dish> dishes;
  final int page;
  final int limit;

  factory DishListModel.fromJson(Map<String, dynamic> json) {
    final list = json['dishes'] as List? ?? const [];
    return DishListModel(
      dishes: list
          .map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }
}