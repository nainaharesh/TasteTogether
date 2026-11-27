import 'package:tastetogether/models/main_application/dish_model.dart';
/// Ek restaurant. Explore, Search, Saved aur Restaurants (list / get) sab
/// ka shape yehi hai. `distanceKm` sirf Restaurants list mein aata hai
/// (abhi hamesha null, kyunke lat/lng bheje nahi jate).
class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.neighborhood,
    required this.address,
    this.lat,
    this.lng,
    this.photoUrl,
    required this.description,
    required this.avgRating,
    required this.reviewCount,
    required this.isSaved,
    this.distanceKm,
    this.createdAt,
  });

  final String id;
  final String name;
  final String cuisine;
  final String neighborhood;
  final String address;
  final double? lat;
  final double? lng;
  final String? photoUrl;
  final String description;
  final double avgRating;
  final int reviewCount;
  final bool isSaved;
  final double? distanceKm;
  final DateTime? createdAt;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'].toString(),
      name: (json['name'] ?? '') as String,
      cuisine: (json['cuisine'] ?? '') as String,
      neighborhood: (json['neighborhood'] ?? '') as String,
      address: (json['address'] ?? '') as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      photoUrl: json['photoUrl'] as String?,
      description: (json['description'] ?? '') as String,
      avgRating: ((json['avgRating'] ?? 0) as num).toDouble(),
      reviewCount: ((json['reviewCount'] ?? 0) as num).toInt(),
      isSaved: (json['isSaved'] ?? false) as bool,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      createdAt: DateTime.tryParse('${json['createdAt']}'),
    );
  }
}

/// GET /api/restaurants?cuisine=&sort=&page=&limit=
/// Response: { restaurants: [...], page, limit }
class RestaurantListModel {
  const RestaurantListModel({
    required this.restaurants,
    required this.page,
    required this.limit,
  });

  final List<Restaurant> restaurants;
  final int page;
  final int limit;

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) {
    final list = json['restaurants'] as List? ?? const [];
    return RestaurantListModel(
      restaurants: list
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }
}

/// GET /api/restaurants/{id}
/// Response: restaurant ki saari fields seedhi + `popularDishes` ki list.
class RestaurantDetailsModel {
  const RestaurantDetailsModel({
    required this.restaurant,
    required this.popularDishes,
  });

  final Restaurant restaurant;
  final List<Dish> popularDishes;

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    final dishes = json['popularDishes'] as List? ?? const [];
    return RestaurantDetailsModel(
      // restaurant ki fields isi map mein hain, popularDishes key ignore hoti hai
      restaurant: Restaurant.fromJson(json),
      popularDishes: dishes
          .map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}