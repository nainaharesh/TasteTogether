import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';

/// Saved list ka aik item: ya restaurant ya dish
class SavedPlace {
  const SavedPlace.restaurant(Restaurant this.restaurant) : dish = null;
  const SavedPlace.dish(Dish this.dish) : restaurant = null;

  final Restaurant? restaurant;
  final Dish? dish;

  bool get isDish => dish != null;

  String get name => isDish ? dish!.name : restaurant!.name;

  /// dish ho to restaurant ka naam, restaurant ho to cuisine
  String get secondary => isDish ? dish!.restaurantName : restaurant!.cuisine;

  double get rating => isDish ? dish!.rating : restaurant!.rating;

  int get count => isDish ? dish!.ratingCount : restaurant!.reviewCount;

  String get subtitle => '${isDish ? 'Dish' : 'Restaurant'} · $secondary';

  String get countLabel => '($count)';

  ////  later on API use here ////
}

/// Dummy data later remove and we use api ////
const List<SavedPlace> dummySavedPlaces = [
  SavedPlace.restaurant(
    Restaurant(
      name: 'Olive & Ember',
      cuisine: 'Mediterranean',
      area: 'Downtown',
      rating: 4.6,
      reviewCount: 248,
    ),
  ),
  SavedPlace.dish(
    Dish(
      name: 'Butter Chicken',
      restaurantName: 'Saffron Table',
      rating: 4.9,
      ratingCount: 132,
    ),
  ),
  SavedPlace.restaurant(
    Restaurant(
      name: 'Koji Counter',
      cuisine: 'Japanese',
      area: 'Midtown',
      rating: 4.7,
      reviewCount: 189,
    ),
  ),
  SavedPlace.dish(
    Dish(
      name: 'Pistachio Croissant',
      restaurantName: 'The Daily Crumb',
      rating: 4.8,
      ratingCount: 97,
    ),
  ),
  SavedPlace.restaurant(
    Restaurant(
      name: 'Smoke & Salt',
      cuisine: 'Barbecue',
      area: 'Harbour',
      rating: 4.6,
      reviewCount: 203,
    ),
  ),
];
