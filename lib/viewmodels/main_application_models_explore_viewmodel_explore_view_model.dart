// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/services/api/api_exception.dart';
import 'package:tastetogether/services/feed_service.dart';

class ExploreController extends GetxController {
  /// Chips: pehla "All", baaki API ki categories (jaise "Indian · Curry House").
  final categories = <String>['All'].obs;
  final RxInt selectedCategory = 0.obs;

  /// Popular restaurants (category chip se filter hoti hain)
  final restaurants = <Restaurant>[].obs;
  final dishes = <Dish>[].obs;
  final nearby = <Restaurant>[].obs;

  /// true jab tak data aa raha hai
  final RxBool isLoading = false.obs;

  final _feedService = FeedService();

  /// API se aayi poori popular list (filter se pehle)
  List<Restaurant> _allRestaurants = [];

  @override
  void onInit() {
    super.onInit();
    fetchExplore();
  }

  /// Screen khulte waqt aur pull to refresh
  Future<void> fetchExplore() async {
    isLoading.value = true;
    try {
      final feed = await _feedService.getExploreFeed();

      categories.assignAll(['All', ...feed.categories]);
      selectedCategory.value = 0;
      _allRestaurants = feed.popularRestaurants;
      restaurants.assignAll(_allRestaurants);
      dishes.assignAll(feed.trendingDishes);
      nearby.assignAll(feed.nearby);
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Server ka jawab samajh nahi aaya. Dobara try karein.');
    } finally {
      isLoading.value = false;
    }
  }

  /// "All" par sab, warna sirf us cuisine ke popular restaurants.
  void selectCategory(int index) {
    selectedCategory.value = index;
    if (index == 0) {
      restaurants.assignAll(_allRestaurants);
    } else {
      final category = categories[index];
      restaurants.assignAll(
        _allRestaurants.where((r) => r.cuisine == category),
      );
    }
  }

  /// Dish ka restaurant: pehle restaurantId se, na mile to naam se.
  Restaurant restaurantOfDish(Dish dish) {
    final all = [..._allRestaurants, ...nearby];
    return all.firstWhere(
      (r) => r.id.isNotEmpty && r.id == dish.restaurantId,
      orElse: () => all.firstWhere(
        (r) => r.name == dish.restaurantName,
        // TODO: restaurant details API aane par restaurantId se fetch hoga
        orElse: () => Restaurant(
          id: dish.restaurantId,
          name: dish.restaurantName,
          cuisine: 'Restaurant',
          area: '',
          rating: dish.rating,
          reviewCount: 0,
        ),
      ),
    );
  }

  void _showError(String message) {
    Get.snackbar('Oops', message, snackPosition: SnackPosition.BOTTOM);
  }
}
