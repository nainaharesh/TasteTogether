class Restaurant {
  final String name;
  final String cuisine;
  final String area;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final double? distanceKm;

  const Restaurant({
    required this.name,
    required this.cuisine,
    required this.area,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.distanceKm,
  });
}