import 'package:tastetogether/models/main_application/review_model.dart';

/// GET /api/feed/home?tab=&page=&limit=
/// Response: { reviews: [...], page, limit, tab }
class HomeFeedModel {
  const HomeFeedModel({
    required this.reviews,
    required this.page,
    required this.limit,
    required this.tab,
  });

  final List<Review> reviews;
  final int page;
  final int limit;
  final String tab;

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) {
    final list = json['reviews'] as List? ?? const [];
    return HomeFeedModel(
      reviews: list
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      tab: (json['tab'] ?? '') as String,
    );
  }
}