import 'package:tastetogether/models/main_application/dish_model.dart';
import 'package:tastetogether/models/main_application/resturant_model.dart';

/// GET /api/saved?type=&page=&limit=
/// Response: { items: [...], page, limit }
class SavedModel {
  const SavedModel({
    required this.items,
    required this.page,
    required this.limit,
  });

  final List<SavedItem> items;
  final int page;
  final int limit;

  factory SavedModel.fromJson(Map<String, dynamic> json) {
    final list = json['items'] as List? ?? const [];
    return SavedModel(
      items: list
          .map((e) => SavedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }
}

/// Ek saved cheez. `type` "restaurant" ho to `restaurant` bhara hota hai,
/// "dish" ho to `dish` (dusra hamesha null).
class SavedItem {
  const SavedItem({
    required this.type,
    this.savedAt,
    this.restaurant,
    this.dish,
  });

  final String type;
  final DateTime? savedAt;
  final Restaurant? restaurant;
  final Dish? dish;

  factory SavedItem.fromJson(Map<String, dynamic> json) {
    return SavedItem(
      type: (json['type'] ?? '') as String,
      savedAt: DateTime.tryParse('${json['savedAt']}'),
      restaurant: json['restaurant'] == null
          ? null
          : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      dish: json['dish'] == null
          ? null
          : Dish.fromJson(json['dish'] as Map<String, dynamic>),
    );
  }
}