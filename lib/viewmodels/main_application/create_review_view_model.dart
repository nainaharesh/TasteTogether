// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastetogether/models/main_application/review_model.dart';
import 'package:tastetogether/widgets/common/action_sheet.dart';

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
  final picker = ImagePicker();

  /// Chuni hui photos (max 3)
  final RxList<XFile> photos = <XFile>[].obs;
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

  /// "Add photo" par: camera ya gallery chuno
  void addPhoto() {
    if (photos.length >= maxPhotos) return;
    ActionSheet.show([
      SheetAction(
        icon: Icons.photo_camera_outlined,
        label: 'Take a photo',
        onTap: () => pickPhoto(ImageSource.camera),
      ),
      SheetAction(
        icon: Icons.image_outlined,
        label: 'Choose from gallery',
        onTap: () => pickPhoto(ImageSource.gallery),
      ),
    ]);
  }

  Future<void> pickPhoto(ImageSource source) async {
    final file = await picker.pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 80,
    );
    if (file != null && photos.length < maxPhotos) photos.add(file);
  }

  void removePhoto(int index) => photos.removeAt(index);

  Future<void> publishReview() async {
    if (!canSubmit || isSubmitting.value) return;
    isSubmitting.value = true;

    // TODO: API par photos (photos[i].path) upload hongi
    // ignore: unused_local_variable
    final review = NewReview(
      restaurantName: restaurantText.value,
      dishName: dishText.value,
      rating: rating.value,
      review: reviewText.value.trim(),
      photoCount: photos.length,
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
