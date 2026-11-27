// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/main_application/dish_model.dart';
import 'package:tastetogether/models/main_application/resturant_model.dart';
import 'package:tastetogether/models/main_application/review_model.dart';

class DishDetailsViewModel extends GetxController {
  DishDetailsViewModel(this.dish);

  final Dish dish;

  final RxBool isSaved = false.obs;
  final RxList<Review> reviews = <Review>[].obs;

  // TODO: ye sab API se aayega, abhi dummy hai
  late final Restaurant restaurant = Restaurant(
    name: dish.restaurantName,
    cuisine: 'Japanese',
    area: 'Downtown',
    rating: 4.7,
    reviewCount: 189,
    distanceKm: 0.4,
  );

  /// 5 se 1 star tak ka hissa (0 se 1)
  final List<double> ratingShare = const [0.78, 0.15, 0.05, 0.01, 0.01];

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  void loadDetails() {
    // TODO: Get data from api//
    // final res = await ApiServices.getDishDetails(dish.id);
    // reviews.assignAll(res.reviews);

    // dumy data///
    reviews.assignAll(dummyDishReviews);
  }

  void toggleSave() {
    // TODO: API - save/unsave dish
    isSaved.toggle();
  }
}
