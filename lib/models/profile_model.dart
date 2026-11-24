import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';

/// Profile grid ka aik tile: kisi restaurant ke dish par diya gaya review
class ProfileReview {
  final Restaurant restaurant;
  final Dish dish;
  final double rating;
  final String? imageUrl;

  const ProfileReview({
    required this.restaurant,
    required this.dish,
    required this.rating,
    this.imageUrl,
  });
}

class UserProfile {
  final String username;
  final String name;
  final String initials;
  final String bio;
  final int reviewCount;
  final int followers;
  final int following;
  final List<ProfileReview> reviews;

  const UserProfile({
    required this.username,
    required this.name,
    required this.initials,
    required this.bio,
    required this.reviewCount,
    required this.followers,
    required this.following,
    required this.reviews,
  });

  ////  later on API use here (fromJson) ////
}

/// 1200 -> 1.2k, 3400 -> 3.4k, 318 -> 318
String compactCount(int n) {
  if (n < 1000) return '$n';
  final k = (n / 1000).toStringAsFixed(1);
  return '${k.endsWith('.0') ? k.substring(0, k.length - 2) : k}k';
}

/// Dummy data later remove and we use api ////
const _restaurants = [
  Restaurant(
    name: 'Olive & Ember',
    cuisine: 'Mediterranean',
    area: 'Downtown',
    rating: 4.6,
    reviewCount: 248,
  ),
  Restaurant(
    name: 'Saffron Table',
    cuisine: 'Indian',
    area: 'Riverside',
    rating: 4.8,
    reviewCount: 312,
  ),
  Restaurant(
    name: 'Koji Counter',
    cuisine: 'Japanese',
    area: 'Midtown',
    rating: 4.7,
    reviewCount: 189,
  ),
];

const _dishes = [
  Dish(
    name: 'Charred Lamb Kofta',
    restaurantName: 'Olive & Ember',
    rating: 4.9,
    ratingCount: 86,
  ),
  Dish(
    name: 'Butter Chicken',
    restaurantName: 'Saffron Table',
    rating: 4.9,
    ratingCount: 132,
  ),
  Dish(
    name: 'Miso Ramen',
    restaurantName: 'Koji Counter',
    rating: 4.7,
    ratingCount: 96,
  ),
];

List<ProfileReview> _reviewsFor(List<double> ratings) => [
  for (var i = 0; i < ratings.length; i++)
    ProfileReview(
      restaurant: _restaurants[i % _restaurants.length],
      dish: _dishes[i % _dishes.length],
      rating: ratings[i],
    ),
];

final UserProfile dummyMyProfile = UserProfile(
  username: 'layla.eats',
  name: 'Layla Hassan',
  initials: 'LH',
  bio: 'Dumpling chaser and pastry loyalist. Reviewing one plate at a time.',
  reviewCount: 42,
  followers: 1200,
  following: 318,
  reviews: _reviewsFor([5.0, 4.0, 5.0, 3.0, 4.0, 5.0]),
);

final UserProfile dummyPublicProfile = UserProfile(
  username: 'danny_dines',
  name: 'Daniel Okoye',
  initials: 'DO',
  bio: 'Pizza obsessive. Slow-cooked anything. Always asks for the sauce on the side.',
  reviewCount: 128,
  followers: 3400,
  following: 210,
  reviews: _reviewsFor([4.0, 5.0, 4.0, 5.0, 3.0, 4.0, 5.0, 4.0, 5.0]),
);
