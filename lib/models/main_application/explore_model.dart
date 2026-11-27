
import 'package:tastetogether/models/main_application/dish_model.dart';
import 'package:tastetogether/models/main_application/resturant_model.dart';

/// GET /api/feed/explore
/// Response: { categories, popularRestaurants, trendingDishes, nearby }
class ExploreFeedModel {
  const ExploreFeedModel({
    required this.categories,
    required this.popularRestaurants,
    required this.trendingDishes,
    required this.nearby,
  });

  final List<String> categories;
  final List<Restaurant> popularRestaurants;
  final List<Dish> trendingDishes;
  final List<Restaurant> nearby;

  factory ExploreFeedModel.fromJson(Map<String, dynamic> json) {
    List<T> list<T>(String key, T Function(Map<String, dynamic>) parse) {
      final raw = json[key] as List? ?? const [];
      return raw.map((e) => parse(e as Map<String, dynamic>)).toList();
    }

    return ExploreFeedModel(
      categories: (json['categories'] as List? ?? const [])
          .map((e) => e.toString())
          .toList(),
      popularRestaurants: list('popularRestaurants', Restaurant.fromJson),
      trendingDishes: list('trendingDishes', Dish.fromJson),
      nearby: list('nearby', Restaurant.fromJson),
    );
  }
}