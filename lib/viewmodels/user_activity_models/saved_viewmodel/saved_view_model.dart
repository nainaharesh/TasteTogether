import 'package:get/get.dart';
import 'package:tastetogether/models/saved_place_model.dart';

class SavedViewModel extends GetxController {
  static const List<String> filters = ['All', 'Restaurants', 'Dishes'];

  final RxInt selectedFilter = 0.obs;
  final RxList<SavedPlace> places = <SavedPlace>[].obs;

  /// Filter lagne ke baad jo list dikhni hai
  List<SavedPlace> get visible {
    return places.where((p) {
      switch (selectedFilter.value) {
        case 1:
          return !p.isDish;
        case 2:
          return p.isDish;
        default:
          return true;
      }
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    // TODO: Get data from api
    // dumy data///
    places.assignAll(dummySavedPlaces);
  }

  void selectFilter(int index) => selectedFilter.value = index;

  void remove(SavedPlace place) {
    // TODO: API par bhi unsave bhejna
    places.remove(place);
  }
}
