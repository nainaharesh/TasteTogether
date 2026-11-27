// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/user_activity/saved_place_model.dart';

import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/api_services/restaurant_service.dart';
import 'package:tastetogether/services/api_services/saved_service.dart';

class SavedViewModel extends GetxController {
  static const List<String> filters = ['All', 'Restaurants', 'Dishes'];

  final RxInt selectedFilter = 0.obs;
  final RxList<SavedPlace> places = <SavedPlace>[].obs;

  /// true jab tak saved list aa rahi hai
  final RxBool isLoading = false.obs;

  final _savedService = SavedService();
  final _restaurantService = RestaurantService();

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
    fetchSaved();
  }

  void selectFilter(int index) => selectedFilter.value = index;

  /// Screen khulte waqt, pull to refresh, aur kahin save / unsave hone par
  Future<void> fetchSaved() async {
    isLoading.value = true;
    try {
      places.assignAll(await _savedService.getSaved());
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Server ka jawab samajh nahi aaya. Dobara try karein.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> remove(SavedPlace place) async {
    final restaurant = place.restaurant;
    if (restaurant != null) {
      try {
        await _restaurantService.unsaveRestaurant(restaurant.id);
      } on ApiException catch (e) {
        _showError(e.message);
        return;
      } catch (_) {
        _showError('Server ka jawab samajh nahi aaya. Dobara try karein.');
        return;
      }
    }
    // TODO: dish ke liye unsave API (Dishes folder) abhi nahi lagi,
    // is liye dish abhi sirf list se hatta hai, server par nahi.
    places.remove(place);
  }

  void _showError(String message) {
    Get.snackbar('Oops', message, snackPosition: SnackPosition.BOTTOM);
  }
}
