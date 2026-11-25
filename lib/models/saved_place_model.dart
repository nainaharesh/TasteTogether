// ignore_for_file: deprecated_member_use
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';

/// Saved list ka aik item: ya restaurant ya dish
class SavedPlace {
  const SavedPlace.restaurant(Restaurant this.restaurant) : dish = null;
  const SavedPlace.dish(Dish this.dish) : restaurant = null;

  final Restaurant? restaurant;
  final Dish? dish;

  /// Saved API ka ek item: { type, savedAt, dish{} | restaurant{} }.
  /// Samajh na aane wala item null deta hai (list se skip ho jata hai).
  static SavedPlace? fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final dish = json['dish'];
    final restaurant = json['restaurant'];

    if (type == 'dish' && dish is Map) {
      return SavedPlace.dish(Dish.fromJson(dish.cast<String, dynamic>()));
    }
    if (type == 'restaurant' && restaurant is Map) {
      return SavedPlace.restaurant(
        Restaurant.fromJson(restaurant.cast<String, dynamic>()),
      );
    }
    return null;
  }

  bool get isDish => dish != null;

  String get name => isDish ? dish!.name : restaurant!.name;

  /// dish ho to restaurant ka naam, restaurant ho to cuisine
  String get secondary => isDish ? dish!.restaurantName : restaurant!.cuisine;

  double get rating => isDish ? dish!.rating : restaurant!.rating;

  int get count => isDish ? dish!.ratingCount : restaurant!.reviewCount;

  String get subtitle {
    final kind = isDish ? 'Dish' : 'Restaurant';
    return secondary.isEmpty ? kind : '$kind · $secondary';
  }

  String get countLabel => '($count)';
}
