


/// Feed ke API calls: Home (Following / Community) aur Explore.
/// Sirf endpoint + query + model: koi UI ya state nahi.
class FeedService {
  /// Home feed ke tab ki values (backend ke `tab` query param ki).
  static const String communityTab = 'community';
  static const String followingTab = 'following'; // TODO: Postman mein confirm karo

  /// GET /api/feed/home?tab=&page=&limit=  ->  { reviews: [...], page, limit, tab }
  Future<List<Post>> getHomeFeed({
    required String tab,
    int page = 1,
    int limit = 20,
  }) async {
    final json = await ApiClient.get(
      ApiEndpoints.homeFeed,
      query: {'tab': tab, 'page': '$page', 'limit': '$limit'},
    ) as Map<String, dynamic>;

    final reviews = json['reviews'] as List? ?? const [];
    return reviews
        .map((e) => Post.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  /// GET /api/feed/explore
  Future<ExploreFeed> getExploreFeed() async {
    final json =
        await ApiClient.get(ApiEndpoints.exploreFeed) as Map<String, dynamic>;
    return ExploreFeed.fromJson(json);
  }
}