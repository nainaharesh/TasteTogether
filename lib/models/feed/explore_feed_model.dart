import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';

class ExploreFeed {
  const ExploreFeed({
    required this.categories,
    required this.popularRestaurants,
    required this.trendingDishes,
    required this.nearby,
  });

  final List<String> categories;
  final List<Restaurant> popularRestaurants;
  final List<Dish> trendingDishes;
  final List<Restaurant> nearby;

  factory ExploreFeed.fromJson(Map<String, dynamic> json) {
    List<T> list<T>(String key, T Function(Map<String, dynamic>) parse) {
      final raw = json[key] as List? ?? const [];
      return raw.map((e) => parse((e as Map).cast<String, dynamic>())).toList();
    }

    return ExploreFeed(
      categories: (json['categories'] as List? ?? const [])
          .map((e) => e.toString())
          .toList(),
      popularRestaurants: list('popularRestaurants', Restaurant.fromJson),
      trendingDishes: list('trendingDishes', Dish.fromJson),
      nearby: list('nearby', Restaurant.fromJson),
    );
  }
}
