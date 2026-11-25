// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/models/review_model.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/restaurant_service.dart';
import 'package:tastetogether/viewmodels/saved_view_model.dart';

class RestaurantDetailsViewModel extends GetxController {
  RestaurantDetailsViewModel(Restaurant initial)
    : restaurant = Rx<Restaurant>(initial),
      isSaved = initial.isSaved.obs;

  /// Pehle wo data jo pichli screen se aaya, API aane par poora data
  final Rx<Restaurant> restaurant;
  final RxBool isSaved;
  final RxList<Dish> dishes = <Dish>[].obs;
  final RxList<Review> reviews = <Review>[].obs;

  final RxBool isLoading = false.obs;
  bool _isSaving = false;

  final _service = RestaurantService();

  String get address => restaurant.value.address;
  String get about => restaurant.value.description;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  /// Restaurant, dishes aur reviews teeno API se. Ek fail ho to baaki phir bhi aate hain.
  Future<void> loadDetails() async {
    final id = restaurant.value.id;
    // id nahi (Search abhi API se nahi judi) to API call nahi ho sakti
    if (id.isEmpty) return;

    isLoading.value = true;
    String? error;

    Future<T?> load<T>(Future<T> Function() call) async {
      try {
        return await call();
      } on ApiException catch (e) {
        error = e.message;
      } catch (_) {
        error = 'Server ka jawab samajh nahi aaya. Dobara try karein.';
      }
      return null;
    }

    final name = restaurant.value.name;
    final results = await Future.wait<Object?>([
      load(() => _service.getRestaurant(id)),
      load(() => _service.getDishes(id, restaurantName: name)),
      load(() => _service.getReviews(id)),
    ]);

    final details = results[0] as Restaurant?;
    final dishList = results[1] as List<Dish>?;
    final reviewList = results[2] as List<Review>?;

    if (details != null) {
      restaurant.value = details;
      isSaved.value = details.isSaved;
    }
    if (dishList != null) dishes.assignAll(dishList);
    if (reviewList != null) reviews.assignAll(reviewList);

    isLoading.value = false;
    if (error != null) {
      Get.snackbar('Oops', error!, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> toggleSave() async {
    final id = restaurant.value.id;
    if (id.isEmpty || _isSaving) return;

    _isSaving = true;
    try {
      isSaved.value = isSaved.value
          ? await _service.unsaveRestaurant(id)
          : await _service.saveRestaurant(id);

      // Saved tab ki list bhi nayi ho jaye
      if (Get.isRegistered<SavedViewModel>()) {
        Get.find<SavedViewModel>().fetchSaved();
      }
    } on ApiException catch (e) {
      Get.snackbar('Oops', e.message, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar(
        'Oops',
        'Server ka jawab samajh nahi aaya. Dobara try karein.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSaving = false;
    }
  }
}
