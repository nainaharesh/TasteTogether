// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/search_filters_model.dart';
import 'package:tastetogether/models/search_result_model.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/restaurant_service.dart';
import 'package:tastetogether/services/search_service.dart';

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

  /// true jab tak results aa rahe hain
  final RxBool isLoading = false.obs;

  final _searchService = SearchService();
  final _restaurantService = RestaurantService();

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
              // TODO: API distance nahi deti (location bhejni hogi), abhi sab dikhte hain
              return true;
            case 4:
              return r.rating >= 4.6; // TODO: API se aayega
            default:
              return true;
          }
        })
        .where((r) {
          // filter sheet: minimum rating aur distance (0 = Any)
          if (r.rating < f.minRating) return false;
          final distance = r.distanceKm;
          if (f.maxDistanceKm != 0 &&
              distance != null &&
              distance > f.maxDistanceKm) {
            return false;
          }
          return true;
        })
        .toList();

    // sort: 0 = Best match (API ka order), 1 = Top rated, 2 = Nearest
    if (f.sort == 1) list.sort((a, b) => b.rating.compareTo(a.rating));
    if (f.sort == 2) {
      // distance na ho to list ka order wahi rehta hai
      list.sort(
        (a, b) => (a.distanceKm ?? double.infinity)
            .compareTo(b.distanceKm ?? double.infinity),
      );
    }
    return list;
  }

  @override
  void onInit() {
    super.onInit();
    search();
  }

  void selectFilter(int index) => selectedFilter.value = index;

  void applyFilters(SearchFilters filters) => appliedFilters.value = filters;

  /// Query ho to search API, khali ho to popular restaurants (Explore ke "See all" se).
  Future<void> search() async {
    query.value = queryController.text.trim();
    isLoading.value = true;
    try {
      if (query.value.isEmpty) {
        final restaurants = await _restaurantService.listRestaurants();
        results.assignAll(restaurants.map(SearchResult.fromRestaurant));
      } else {
        results.assignAll(await _searchService.search(query.value));
      }
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Server ka jawab samajh nahi aaya. Dobara try karein.');
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    Get.snackbar('Oops', message, snackPosition: SnackPosition.BOTTOM);
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
