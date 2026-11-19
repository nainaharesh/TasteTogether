class Dish {
  final String name;
  final String restaurantName;
  final double rating;
  final int ratingCount;
  final String? imageUrl;

  const Dish({
    required this.name,
    required this.restaurantName,
    required this.rating,
    this.ratingCount = 0,
    this.imageUrl,
  });

  ////  later on API use here ////
}
