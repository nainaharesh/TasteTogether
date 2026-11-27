
import 'package:tastetogether/models/user_activity/saved_place_model.dart';
import 'package:tastetogether/services/api/api_client.dart';
import 'package:tastetogether/services/api/api_endpoints.dart';

/// Saved list ka API call.
class SavedService {
  /// GET /api/saved?type=all&page=&limit=
  /// -> { items: [ { type: "dish" | "restaurant", savedAt, dish: {...} | restaurant: {...} } ] }
  Future<List<SavedPlace>> getSaved({
    String type = 'all',
    int page = 1,
    int limit = 20,
  }) async {
    final json = await ApiClient.get(
      ApiEndpoints.saved,
      query: {'type': type, 'page': '$page', 'limit': '$limit'},
    ) as Map<String, dynamic>;

    final items = json['items'] as List? ?? const [];
    return items
        .map((e) => SavedPlace.fromJson((e as Map).cast<String, dynamic>()))
        .whereType<SavedPlace>()
        .toList();
  }
}
