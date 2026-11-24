/// Filter sheet ka result: sort + minimum rating + distance
class SearchFilters {
  /// 0 = Best match, 1 = Top rated, 2 = Nearest
  final int sort;

  /// 0 ka matlab "Any"
  final double minRating;

  /// km mein, 0 ka matlab "Any"
  final double maxDistanceKm;

  const SearchFilters({
    this.sort = 0,
    this.minRating = 0,
    this.maxDistanceKm = 0,
  });

  static const List<String> sortOptions = [
    'Best match',
    'Top rated',
    'Nearest',
  ];

  SearchFilters copyWith({
    int? sort,
    double? minRating,
    double? maxDistanceKm,
  }) => SearchFilters(
    sort: sort ?? this.sort,
    minRating: minRating ?? this.minRating,
    maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
  );

  bool get isDefault => sort == 0 && minRating == 0 && maxDistanceKm == 0;

  ////  later on API use here (query params) ////
}
