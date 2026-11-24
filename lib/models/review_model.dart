/// Create Review screen se jo data API ko jayega
class NewReview {
  final String restaurantName;
  final String dishName;
  final int rating;
  final String review;
  final int photoCount;

  const NewReview({
    required this.restaurantName,
    required this.dishName,
    required this.rating,
    required this.review,
    this.photoCount = 0,
  });

  ////  later on API use here ////
  // TODO: restaurantName ki jagah restaurantId bheji jayegi, photos multipart me
  Map<String, dynamic> toJson() => {
    'restaurant_name': restaurantName,
    'dish_name': dishName,
    'rating': rating,
    'review': review,
  };
}

/// Restaurant / Dish details par dikhne wala customer review
class Review {
  final String id;
  final String username;
  final String initials;
  final String date;
  final int rating;
  final String text;

  /// 0 = sand, 1 = terracotta, 2 = charcoal (avatar ka rang)
  final int avatarStyle;

  /// photo ho to uska label (abhi placeholder), null = photo nahi
  final String? photoLabel;

  const Review({
    required this.id,
    required this.username,
    required this.initials,
    required this.date,
    required this.rating,
    required this.text,
    this.avatarStyle = 0,
    this.photoLabel,
  });

  ////  later on API use here ////
  // factory Review.fromJson(Map<String, dynamic> json) { ... }
}

/// Dummy data later remove and we use api ////
const List<Review> dummyRestaurantReviews = [
  Review(
    id: 'r1',
    username: 'sofia.bites',
    initials: 'SM',
    date: '12 Oct 2026',
    rating: 5,
    text:
        'Went on a Tuesday and it was lively without being packed. The lamb kofta and charred broccolini were the standouts, and the service was warm and unhurried.',
  ),
  Review(
    id: 'r2',
    username: 'lucas.m',
    initials: 'LM',
    date: '3 Oct 2026',
    rating: 4,
    avatarStyle: 1,
    text:
        'Great mezze platter. The smoked aubergine dip is the one to get. Dessert was a little sweet for my taste.',
    photoLabel: 'Mezze platter',
  ),
  Review(
    id: 'r3',
    username: 'hira.cooks',
    initials: 'HK',
    date: '28 Sep 2026',
    rating: 5,
    avatarStyle: 2,
    text:
        'Booked for a birthday and they brought out a little pistachio cake without being asked. Lovely touch.',
  ),
];

const List<Review> dummyDishReviews = [
  Review(
    id: 'd1',
    username: 'mei.tanaka',
    initials: 'MT',
    date: '9 Nov 2026',
    rating: 5,
    avatarStyle: 2,
    text:
        'Rich, savoury broth with a proper hit of corn butter. The noodles had real bite.',
  ),
  Review(
    id: 'd2',
    username: 'priya.n',
    initials: 'PN',
    date: '2 Nov 2026',
    rating: 4,
    text:
        "Great depth in the miso. I'd ask for the egg extra soft next time.",
  ),
  Review(
    id: 'd3',
    username: 'omar.s',
    initials: 'OS',
    date: '27 Oct 2026',
    rating: 5,
    avatarStyle: 1,
    text: 'Best bowl within walking distance. Go early, the queue builds by 7.',
  ),
];
