import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/review_model.dart';

class CreateReviewViewModel extends GetxController {
  CreateReviewViewModel({String? restaurantName, String? dishName})
    : restaurantController = TextEditingController(text: restaurantName),
      dishController = TextEditingController(text: dishName);

  static const int maxPhotos = 3;
  static const int maxReviewLength = 500;
  static const List<String> ratingLabels = [
    '',
    'Poor',
    'Fair',
    'Good',
    'Great',
    'Outstanding',
  ];

  final TextEditingController restaurantController;
  final TextEditingController dishController;
  final reviewController = TextEditingController();

  final RxInt rating = 0.obs;
  final RxInt photoCount = 0.obs;
  final RxBool isSubmitting = false.obs;

  // button enable/disable aur counter ke liye text ko observe karte hain
  final RxString restaurantText = ''.obs;
  final RxString dishText = ''.obs;
  final RxString reviewText = ''.obs;

  String get ratingLabel => ratingLabels[rating.value];

  bool get canSubmit =>
      restaurantText.value.isNotEmpty &&
      dishText.value.isNotEmpty &&
      reviewText.value.isNotEmpty &&
      rating.value > 0;

  @override
  void onInit() {
    super.onInit();
    restaurantText.value = restaurantController.text.trim();
    dishText.value = dishController.text.trim();
    restaurantController.addListener(
      () => restaurantText.value = restaurantController.text.trim(),
    );
    dishController.addListener(
      () => dishText.value = dishController.text.trim(),
    );
    reviewController.addListener(
      () => reviewText.value = reviewController.text,
    );
  }

  void setRating(int value) => rating.value = value;

  void addPhoto() {
    if (photoCount.value >= maxPhotos) return;
    // TODO: image_picker se gallery/camera open hoga, abhi sirf placeholder
    photoCount.value++;
  }

  void removePhoto() {
    if (photoCount.value > 0) photoCount.value--;
  }

  Future<void> publishReview() async {
    if (!canSubmit || isSubmitting.value) return;
    isSubmitting.value = true;

    // ignore: unused_local_variable
    final review = NewReview(
      restaurantName: restaurantText.value,
      dishName: dishText.value,
      rating: rating.value,
      review: reviewText.value.trim(),
      photoCount: photoCount.value,
    );

    // TODO: API
    // await ApiServices.createReview(review.toJson());
    // fake delay, API lagne par hata dena
    await Future.delayed(const Duration(milliseconds: 600));

    isSubmitting.value = false;
    Get.back();
    Get.snackbar('Review published', 'Thanks for sharing your taste!');
  }

  @override
  void onClose() {
    restaurantController.dispose();
    dishController.dispose();
    reviewController.dispose();
    super.onClose();
  }
}
