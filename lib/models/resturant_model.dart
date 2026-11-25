// ignore_for_file: deprecated_member_use
class Restaurant {
  final String id; // API id ("rst_..."). Dummy / search data mein khali.
  final String name;
  final String cuisine;
  final String area;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final double? distanceKm;

  // API se aane wali extra cheezein
  final String address;
  final String description;
  final double? lat;
  final double? lng;
  final bool isSaved;

  const Restaurant({
    this.id = '',
    required this.name,
    required this.cuisine,
    required this.area,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.distanceKm,
    this.address = '',
    this.description = '',
    this.lat,
    this.lng,
    this.isSaved = false,
  });

  /// Explore API (popularRestaurants / nearby) ka ek restaurant:
  /// { id, name, cuisine, neighborhood, address, lat, lng, photoUrl,
  ///   description, avgRating, reviewCount, isSaved, createdAt }
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'].toString(),
      name: (json['name'] ?? '') as String,
      cuisine: (json['cuisine'] ?? '') as String,
      area: (json['neighborhood'] ?? '') as String,
      rating: ((json['avgRating'] ?? 0) as num).toDouble(),
      reviewCount: ((json['reviewCount'] ?? 0) as num).toInt(),
      imageUrl: json['photoUrl'] as String?,
      address: (json['address'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      isSaved: (json['isSaved'] ?? false) as bool,
    );
  }
}
