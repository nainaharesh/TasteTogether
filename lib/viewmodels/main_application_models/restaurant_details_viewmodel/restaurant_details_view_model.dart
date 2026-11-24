import 'package:get/get.dart';
import 'package:tastetogether/models/dish_model.dart';
import 'package:tastetogether/models/resturant_model.dart';
import 'package:tastetogether/models/review_model.dart';

class RestaurantDetailsViewModel extends GetxController {
  RestaurantDetailsViewModel(this.restaurant);

  final Restaurant restaurant;

  final RxBool isSaved = false.obs;
  final RxList<Dish> dishes = <Dish>[].obs;
  final RxList<Review> reviews = <Review>[].obs;

  // TODO: ye restaurant model/API se aayega, abhi dummy hai
  final String address = '14 Harbour Street, Downtown';
  final String about =
      'Wood-fired grill and small plates inspired by the eastern '
      'Mediterranean. Shared tables, a short seasonal menu and a loud, '
      'friendly dining room.';

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  void loadDetails() {
    // TODO: Get data from api//
    // final res = await ApiServices.getRestaurantDetails(restaurant.id);
    // dishes.assignAll(res.dishes);
    // reviews.assignAll(res.reviews);

    // dumy data///
    dishes.assignAll([
      Dish(
        name: 'Charred Lamb Kofta',
        restaurantName: restaurant.name,
        rating: 4.9,
        ratingCount: 86,
      ),
      Dish(
        name: 'Whipped Feta',
        restaurantName: restaurant.name,
        rating: 4.7,
        ratingCount: 64,
      ),
      Dish(
        name: 'Grilled Sea Bream',
        restaurantName: restaurant.name,
        rating: 4.6,
        ratingCount: 41,
      ),
    ]);
    reviews.assignAll(dummyRestaurantReviews);
  }

  void toggleSave() {
    // TODO: API - save/unsave restaurant
    isSaved.toggle();
  }
}
