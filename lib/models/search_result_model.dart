enum SearchResultType { dish, restaurant }

class SearchResult {
  final SearchResultType type;
  final String name;

  /// dish ho to restaurant ka naam, restaurant ho to cuisine
  final String secondary;
  final double distanceKm;
  final double rating;

  /// dish: ratings ki tadad, restaurant: reviews ki tadad
  final int count;

  const SearchResult({
    required this.type,
    required this.name,
    required this.secondary,
    required this.distanceKm,
    required this.rating,
    required this.count,
  });

  bool get isDish => type == SearchResultType.dish;

  String get subtitle => '$secondary · ${distanceKm.toStringAsFixed(1)} km';

  String get countLabel => isDish ? '($count)' : '($count reviews)';

  ////  later on API use here ////
}

/// Dummy data later remove and we use api ////
const List<SearchResult> dummySearchResults = [
  SearchResult(
    type: SearchResultType.dish,
    name: 'Miso Ramen',
    secondary: 'Koji Counter',
    distanceKm: 0.4,
    rating: 4.7,
    count: 96,
  ),
  SearchResult(
    type: SearchResultType.restaurant,
    name: 'Koji Counter',
    secondary: 'Japanese',
    distanceKm: 0.4,
    rating: 4.7,
    count: 189,
  ),
  SearchResult(
    type: SearchResultType.dish,
    name: 'Tonkotsu Ramen',
    secondary: 'Hana Noodle Bar',
    distanceKm: 1.8,
    rating: 4.5,
    count: 61,
  ),
  SearchResult(
    type: SearchResultType.restaurant,
    name: 'Hana Noodle Bar',
    secondary: 'Japanese',
    distanceKm: 1.8,
    rating: 4.5,
    count: 142,
  ),
  SearchResult(
    type: SearchResultType.dish,
    name: 'Kimchi Ramen',
    secondary: 'Seoul Street',
    distanceKm: 2.3,
    rating: 4.4,
    count: 38,
  ),
];
