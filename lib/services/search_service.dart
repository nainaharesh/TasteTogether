import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/models/search_result_model.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';

/// Search ka API call.
class SearchService {
  /// GET /api/search?q=&type=all&sort=best_match
  /// -> { restaurants: [...], dishes: [...] }   (pehle restaurants, phir dishes)
  Future<List<SearchResult>> search(
    String query, {
    String type = 'all',
    String sort = 'best_match',
  }) async {
    final json = await ApiClient.get(
      ApiEndpoints.search,
      query: {'q': query, 'type': type, 'sort': sort},
    ) as Map<String, dynamic>;

    final restaurants = (json['restaurants'] as List? ?? const []).map(
      (e) => SearchResult.fromRestaurant(
        Restaurant.fromJson((e as Map).cast<String, dynamic>()),
      ),
    );
    final dishes = (json['dishes'] as List? ?? const []).map(
      (e) => SearchResult.fromDish(
        Dish.fromJson((e as Map).cast<String, dynamic>()),
      ),
    );

    return [...restaurants, ...dishes];
  }
}
