class Post {
  final String id;
  final String username;
  final String initials;
  final String restaurant;
  final String timeAgo;
  final String dishName;
  final double rating;
  final String review;
  final int likes;
  final int comments;
  final String? imageUrl;
  final bool isLiked;
  final bool isSaved;

  const Post({
    required this.id,
    required this.username,
    required this.initials,
    required this.restaurant,
    required this.timeAgo,
    required this.dishName,
    required this.rating,
    required this.review,
    required this.likes,
    required this.comments,
    this.imageUrl,
    this.isLiked = false,
    this.isSaved = false,
  });

  Post copyWith({bool? isLiked, bool? isSaved, int? likes}) => Post(
    id: id,
    username: username,
    initials: initials,
    restaurant: restaurant,
    timeAgo: timeAgo,
    dishName: dishName,
    rating: rating,
    review: review,
    likes: likes ?? this.likes,
    comments: comments,
    imageUrl: imageUrl,
    isLiked: isLiked ?? this.isLiked,
    isSaved: isSaved ?? this.isSaved,
  );
}

/// Dummy data later remove and we use api ////
const List<Post> dummyPosts = [
  Post(
    id: '1',
    username: 'amina.eats',
    initials: 'AR',
    restaurant: 'Olive & Ember',
    timeAgo: '2h ago',
    dishName: 'Charred Lamb Kofta',
    rating: 5.0,
    review: "Smoky off the grill, with whipped feta underneath that I'd happily eat alone. Order extra flatbread.",
    likes: 129,
    comments: 14,
    isLiked: true,
  ),
  Post(
    id: '2',
    username: 'danny_dines',
    initials: 'DO',
    restaurant: 'Saffron Table',
    timeAgo: '5h ago',
    dishName: 'Butter Chicken',
    rating: 4.5,
    review: 'Creamy and rich, the naan is soft and fresh.',
    likes: 64,
    comments: 7,
  ),
  Post(
    id: '3',
    username: 'sofia.bites',
    initials: 'SM',
    restaurant: 'The Daily Crumb',
    timeAgo: '1d ago',
    dishName: 'Pistachio Croissant',
    rating: 4.0,
    review: 'Flaky outside, a little too sweet for me, but worth a try.',
    likes: 31,
    comments: 3,
  ),
];
