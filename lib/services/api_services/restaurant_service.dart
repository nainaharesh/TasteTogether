import 'package:tastetogether/models/main_application/dish_model.dart';
import 'package:tastetogether/models/main_application/feed/homefeed_model.dart' hide Dish;


import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';

/// Restaurant ke API calls: details, reviews, dishes, save / unsave.
class RestaurantService {
  /// GET /api/restaurants?cuisine=all&sort=popular&page=&limit=  ->  { restaurants: [...] }
  Future<List<Restaurant>> listRestaurants({
    String cuisine = 'all',
    String sort = 'popular',
    int page = 1,
    int limit = 20,
  }) async {
    final json = await ApiClient.get(
      ApiEndpoints.restaurants,
      query: {
        'cuisine': cuisine,
        'sort': sort,
        'page': '$page',
        'limit': '$limit',
      },
    ) as Map<String, dynamic>;

    final list = json['restaurants'] as List? ?? const [];
    return list
        .map((e) => Restaurant.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  /// GET /api/restaurants/{id}  ->  seedha restaurant object
  Future<Restaurant> getRestaurant(String id) async {
    final json =
        await ApiClient.get(ApiEndpoints.restaurant(id)) as Map<String, dynamic>;
    return Restaurant.fromJson(json);
  }

  /// GET /api/restaurants/{id}/reviews?page=&limit=  ->  { reviews: [...] }
  Future<List<Review>> getReviews(
    String id, {
    int page = 1,
    int limit = 20,
  }) async {
    final json = await ApiClient.get(
      ApiEndpoints.restaurantReviews(id),
      query: {'page': '$page', 'limit': '$limit'},
    ) as Map<String, dynamic>;

    final list = json['reviews'] as List? ?? const [];
    return list
        .map((e) => Review.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  /// GET /api/restaurants/{id}/dishes?page=&limit=  ->  { dishes: [...] }
  Future<List<Dish>> getDishes(
    String id, {
    required String restaurantName,
    int page = 1,
    int limit = 20,
  }) async {
    final json = await ApiClient.get(
      ApiEndpoints.restaurantDishes(id),
      query: {'page': '$page', 'limit': '$limit'},
    ) as Map<String, dynamic>;

    final list = json['dishes'] as List? ?? const [];
    return list
        .map(
          (e) => Dish.fromJson(
            (e as Map).cast<String, dynamic>(),
            restaurantName: restaurantName,
          ),
        )
        .toList();
  }

  /// POST /api/restaurants/{id}/save  ->  { isSaved: true }
  Future<bool> saveRestaurant(String id) async {
    final json = await ApiClient.post(ApiEndpoints.restaurantSave(id));
    return _isSaved(json, fallback: true);
  }

  /// DELETE /api/restaurants/{id}/save  ->  { isSaved: false }
  Future<bool> unsaveRestaurant(String id) async {
    final json = await ApiClient.delete(ApiEndpoints.restaurantSave(id));
    return _isSaved(json, fallback: false);
  }

  bool _isSaved(dynamic json, {required bool fallback}) {
    if (json is Map && json['isSaved'] is bool) return json['isSaved'] as bool;
    return fallback;
  }
}
