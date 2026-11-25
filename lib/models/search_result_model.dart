// ignore_for_file: deprecated_member_use
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';

enum SearchResultType { dish, restaurant }

/// Search list ka ek item. Asli dish / restaurant saath rehta hai,
/// taake tap par uski id se details khul sakein.
class SearchResult {
  final SearchResultType type;
  final String name;

  /// dish ho to restaurant ka naam, restaurant ho to cuisine
  final String secondary;

  /// API distance nahi deti (user ki location abhi bheji nahi jati), isliye null
  final double? distanceKm;
  final double rating;

  /// dish: ratings ki tadad, restaurant: reviews ki tadad
  final int count;

  final Restaurant? restaurant;
  final Dish? dish;

  const SearchResult._({
    required this.type,
    required this.name,
    required this.secondary,
    required this.rating,
    required this.count,
    this.distanceKm,
    this.restaurant,
    this.dish,
  });

  factory SearchResult.fromRestaurant(Restaurant r) => SearchResult._(
    type: SearchResultType.restaurant,
    name: r.name,
    secondary: r.cuisine,
    rating: r.rating,
    count: r.reviewCount,
    distanceKm: r.distanceKm,
    restaurant: r,
  );

  factory SearchResult.fromDish(Dish d) => SearchResult._(
    type: SearchResultType.dish,
    name: d.name,
    secondary: d.restaurantName,
    rating: d.rating,
    count: d.ratingCount,
    dish: d,
  );

  bool get isDish => type == SearchResultType.dish;

  String get subtitle {
    final distance = distanceKm;
    if (distance == null) return secondary;
    return '$secondary · ${distance.toStringAsFixed(1)} km';
  }

  String get countLabel => isDish ? '($count)' : '($count reviews)';
}
