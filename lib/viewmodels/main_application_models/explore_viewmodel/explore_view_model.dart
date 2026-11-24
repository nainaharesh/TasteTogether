import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';

class ExploreController extends GetxController {
  final List<String> categories = [
    'All',
    'Italian',
    'Japanese',
    'Burgers',
    'Desserts',
    'Pizza',
  ];

  final RxInt selectedCategory = 0.obs;

  final restaurants = <Restaurant>[
    const Restaurant(
      name: 'Olive & Ember',
      cuisine: 'Mediterranean',
      area: 'Downtown',
      rating: 4.6,
      reviewCount: 248,
    ),
    const Restaurant(
      name: 'Saffron Table',
      cuisine: 'Indian',
      area: 'Riverside',
      rating: 4.8,
      reviewCount: 312,
    ),
    const Restaurant(
      name: 'The Urban Fork',
      cuisine: 'Italian',
      area: 'City Center',
      rating: 4.5,
      reviewCount: 186,
    ),
    const Restaurant(
      name: 'Spice Garden',
      cuisine: 'Pakistani',
      area: 'Clifton',
      rating: 4.7,
      reviewCount: 420,
    ),
    const Restaurant(
      name: 'Coastal Kitchen',
      cuisine: 'Japanese',
      area: 'Seaview',
      rating: 4.9,
      reviewCount: 275,
    ),
  ].obs;

  final dishes = <Dish>[
    const Dish(
      name: 'Butter Chicken',
      restaurantName: 'Saffron Table',
      rating: 4.9,
    ),
    const Dish(name: 'Miso Ramen', restaurantName: 'Koji Counter', rating: 4.7),
    const Dish(
      name: 'Smash Burger',
      restaurantName: 'Smoke & Salt',
      rating: 4.6,
    ),
    const Dish(
      name: 'Pistachio Croissant',
      restaurantName: 'The Daily Crumb',
      rating: 4.8,
    ),
  ].obs;

  final nearby = <Restaurant>[
    const Restaurant(
      name: 'Koji Counter',
      cuisine: 'Japanese',
      area: 'Downtown',
      rating: 4.7,
      reviewCount: 189,
      distanceKm: 0.4,
    ),
    const Restaurant(
      name: 'The Daily Crumb',
      cuisine: 'Café & Bakery',
      area: 'Downtown',
      rating: 4.8,
      reviewCount: 421,
      distanceKm: 0.9,
    ),

    const Restaurant(
      name: 'Burger Lab',
      cuisine: 'Burgers',
      area: 'Downtown',
      rating: 4.5,
      reviewCount: 156,
      distanceKm: 1.2,
    ),
    const Restaurant(
      name: 'Sakura Sushi',
      cuisine: 'Japanese',
      area: 'Downtown',
      rating: 4.6,
      reviewCount: 203,
      distanceKm: 1.5,
    ),
  ].obs;

  void selectCategory(int index) {
    selectedCategory.value = index;
  }

  /// Dish se uska restaurant dhoondta hai (dish model me abhi restaurantId nahi)
  Restaurant restaurantOfDish(Dish dish) {
    final all = [...restaurants, ...nearby];
    return all.firstWhere(
      (r) => r.name == dish.restaurantName,
      // TODO: API aane par restaurantId se fetch hoga
      orElse: () => Restaurant(
        name: dish.restaurantName,
        cuisine: 'Restaurant',
        area: '',
        rating: dish.rating,
        reviewCount: 0,
      ),
    );
  }
}
