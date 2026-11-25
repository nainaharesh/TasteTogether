// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/create_review_view_model.dart';
//import 'package:tastetogether/viewmodels/main_application_models/create_review_viewmodel/create_review_view_model.dart';
import 'package:tastetogether/widgets/create_review/labeled_field.dart';
import 'package:tastetogether/widgets/create_review/photo_tiles.dart';
import 'package:tastetogether/widgets/create_review/star_rating_picker.dart';

class CreateReview extends StatelessWidget {
  CreateReview({super.key, this.restaurantName, this.dishName});

  /// Details screen se aaye to pehle se bhara hota hai, "+" button se aaye to null
  final String? restaurantName;
  final String? dishName;

  late final CreateReviewViewModel controller = Get.put(
    CreateReviewViewModel(restaurantName: restaurantName, dishName: dishName),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // close
                      SizedBox(
                        height: 56.h,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Transform.translate(
                            offset: Offset(-8.w, 0),
                            child: IconButton(
                              onPressed: Get.back,
                              constraints: BoxConstraints.tightFor(
                                width: 44.r,
                                height: 44.r,
                              ),
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.close,
                                size: 24.r,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Write a Review',
                        style: TextStyle(
                          fontSize: 28.sp,
                          height: 36 / 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      Column(
                        spacing: 12.h,
                        children: [
                          // Restaurant
                          LabeledField(
                            label: 'Restaurant',
                            child: IconTextField(
                              controller: controller.restaurantController,
                              icon: Icons.search_rounded,
                              hintText: 'Search restaurant',
                              // TODO: restaurant search API (autocomplete)
                              textCapitalization: TextCapitalization.words,
                            ),
                          ),

                          // Dish
                          LabeledField(
                            label: 'Dish name',
                            child: IconTextField(
                              controller: controller.dishController,
                              icon: Icons.restaurant_menu_rounded,
                              hintText: 'What did you eat?',
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),

                          // Rating
                          LabeledField(
                            label: 'Your rating',
                            child: Obx(
                              () => StarRatingPicker(
                                rating: controller.rating.value,
                                label: controller.ratingLabel,
                                onChanged: controller.setRating,
                              ),
                            ),
                          ),

                          // Review
                          LabeledField(
                            label: 'Your review',
                            child: SizedBox(
                              height: 112.h,
                              child: Stack(
                                children: [
                                  TextField(
                                    controller: controller.reviewController,
                                    expands: true,
                                    maxLines: null,
                                    minLines: null,
                                    textAlignVertical: TextAlignVertical.top,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    cursorColor: AppColors.primary,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                        CreateReviewViewModel.maxReviewLength,
                                      ),
                                    ],
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      height: 22 / 15,
                                      color: AppColors.textPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Tell others what you liked',
                                      hintStyle: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.textMuted,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.surface,
                                      contentPadding: EdgeInsets.fromLTRB(
                                        16.w,
                                        14.h,
                                        16.w,
                                        28.h,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          14.r,
                                        ),
                                        borderSide: const BorderSide(
                                          color: AppColors.fieldBorder,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          14.r,
                                        ),
                                        borderSide: const BorderSide(
                                          color: AppColors.primary,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 14.w,
                                    bottom: 8.h,
                                    child: Obx(
                                      () => Text(
                                        '${controller.reviewText.value.length} / ${CreateReviewViewModel.maxReviewLength}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Photo
                          LabeledField(
                            label: 'Photo',
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Obx(
                                () => Wrap(
                                  spacing: 12.w,
                                  runSpacing: 12.h,
                                  children: [
                                    for (
                                      var i = 0;
                                      i < controller.photos.length;
                                      i++
                                    )
                                      SelectedPhotoTile(
                                        path: controller.photos[i].path,
                                        onRemove: () =>
                                            controller.removePhoto(i),
                                      ),
                                    if (controller.photos.length <
                                        CreateReviewViewModel.maxPhotos)
                                      AddPhotoTile(onTap: controller.addPhoto),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Publish
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
                child: Obx(
                  () => FilledButton(
                    onPressed:
                        controller.canSubmit && !controller.isSubmitting.value
                        ? controller.publishReview
                        : null,
                    child: controller.isSubmitting.value
                        ? SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.surface,
                            ),
                          )
                        : Text(
                            'Publish review',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
