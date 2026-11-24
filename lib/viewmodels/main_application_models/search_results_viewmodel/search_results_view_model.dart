import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/search_filters_model.dart';
import 'package:tastetogether/models/search_result_model.dart';

class SearchResultsViewModel extends GetxController {
  SearchResultsViewModel({
    String query = '',
    int initialFilter = 0,
    SearchFilters filters = const SearchFilters(),
  }) : queryController = TextEditingController(text: query),
       selectedFilter = initialFilter.obs,
       appliedFilters = filters.obs;

  static const List<String> filters = [
    'All',
    'Dishes',
    'Restaurants',
    'Nearby',
    'Top rated',
  ];

  final TextEditingController queryController;
  final RxString query = ''.obs;
  final RxInt selectedFilter;

  /// Filter sheet se aaye hue sort / min rating / distance
  final Rx<SearchFilters> appliedFilters;
  final RxList<SearchResult> results = <SearchResult>[].obs;

  /// Filter lagne ke baad jo list dikhni hai
  List<SearchResult> get filtered {
    final f = appliedFilters.value;
    final list = results
        .where((r) {
          switch (selectedFilter.value) {
            case 1:
              return r.isDish;
            case 2:
              return !r.isDish;
            case 3:
              return r.distanceKm <= 2.0; // TODO: API se aayega
            case 4:
              return r.rating >= 4.6; // TODO: API se aayega
            default:
              return true;
          }
        })
        .where((r) {
          // filter sheet: minimum rating aur distance (0 = Any)
          if (r.rating < f.minRating) return false;
          if (f.maxDistanceKm != 0 && r.distanceKm > f.maxDistanceKm) {
            return false;
          }
          return true;
        })
        .toList();

    // sort: 0 = Best match (API ka order), 1 = Top rated, 2 = Nearest
    if (f.sort == 1) list.sort((a, b) => b.rating.compareTo(a.rating));
    if (f.sort == 2) list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return list;
  }

  @override
  void onInit() {
    super.onInit();
    query.value = queryController.text.trim();
    search();
  }

  void selectFilter(int index) => selectedFilter.value = index;

  void applyFilters(SearchFilters filters) => appliedFilters.value = filters;

  void search() {
    query.value = queryController.text.trim();
    // TODO: Get data from api// (query + filter bhej kar)
    // final res = await ApiServices.search(query.value);
    // results.assignAll(res);

    // dumy data///
    results.assignAll(dummySearchResults);
  }

  void clearQuery() {
    queryController.clear();
    query.value = '';
  }

  @override
  void onClose() {
    queryController.dispose();
    super.onClose();
  }
}
