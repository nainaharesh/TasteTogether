// ignore_for_file: deprecated_member_use
class Dish {
  final String id; // API id ("dsh_..."). Dummy / search data mein khali.
  final String restaurantId;
  final String name;
  final String restaurantName;
  final double rating;
  final int ratingCount;
  final String? imageUrl;

  // API se aane wali extra cheezein
  final int? priceCents;
  final bool isSaved;

  const Dish({
    this.id = '',
    this.restaurantId = '',
    required this.name,
    required this.restaurantName,
    required this.rating,
    this.ratingCount = 0,
    this.imageUrl,
    this.priceCents,
    this.isSaved = false,
  });

  /// Explore API (trendingDishes) ka ek dish:
  /// { id, restaurantId, name, photoUrl, priceCents, avgRating, reviewCount,
  ///   isSaved, restaurantName, createdAt }
  ///
  /// Restaurant ke dishes API mein `restaurantName` nahi aata, is liye
  /// [restaurantName] se bhara jata hai.
  factory Dish.fromJson(
    Map<String, dynamic> json, {
    String restaurantName = '',
  }) {
    return Dish(
      id: json['id'].toString(),
      restaurantId: (json['restaurantId'] ?? '').toString(),
      name: (json['name'] ?? '') as String,
      restaurantName: (json['restaurantName'] ?? restaurantName) as String,
      rating: ((json['avgRating'] ?? 0) as num).toDouble(),
      ratingCount: ((json['reviewCount'] ?? 0) as num).toInt(),
      imageUrl: json['photoUrl'] as String?,
      priceCents: (json['priceCents'] as num?)?.toInt(),
      isSaved: (json['isSaved'] ?? false) as bool,
    );
  }
}
