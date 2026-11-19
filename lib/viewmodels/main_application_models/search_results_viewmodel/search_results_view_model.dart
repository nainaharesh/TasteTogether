import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/search_result_model.dart';

class SearchResultsViewModel extends GetxController {
  SearchResultsViewModel({String query = ''})
    : queryController = TextEditingController(text: query);

  static const List<String> filters = [
    'All',
    'Dishes',
    'Restaurants',
    'Nearby',
    'Top rated',
  ];

  final TextEditingController queryController;
  final RxString query = ''.obs;
  final RxInt selectedFilter = 0.obs;
  final RxList<SearchResult> results = <SearchResult>[].obs;

  /// Filter lagne ke baad jo list dikhni hai
  List<SearchResult> get filtered {
    return results.where((r) {
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
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    query.value = queryController.text.trim();
    search();
  }

  void selectFilter(int index) => selectedFilter.value = index;

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
