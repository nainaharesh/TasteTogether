// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/viewmodels/edit_profile_controller.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/appcolors.dart';

import '../../widgets/components/app_page_layout.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  EditProfileController get controller => Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Edit Profile',
      children: [
        SizedBox(height: 12.h),

        // Avatar + "Change profile photo"
        Center(
          child: Column(
            children: [
              buildAvatar(),
              SizedBox(height: 4.h),
              TextButton(
                onPressed: controller.pickPhoto,
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 44.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                ),
                child: Text(
                  'Change profile photo',
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDeep,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        Form(
          key: controller.formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Full name',
                hint: 'Your full name',
                prefixIcon: Icons.person_outline,
                controller: controller.nameController,
                validator: controller.validateName,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Username',
                hint: 'choose_a_username',
                prefixIcon: Icons.alternate_email,
                controller: controller.usernameController,
                validator: controller.validateUsername,
              ),
              SizedBox(height: 16.h),

              // Bio: multi-line field with a "66 / 160" counter inside it.
              // Stack + Positioned places the counter over the field.
              Stack(
                children: [
                  CustomTextField(
                    label: 'Bio',
                    hint: 'Write a short bio',
                    controller: controller.bioController,
                    maxLines: 3,
                    maxLength: EditProfileController.bioMaxLength,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                  Positioned(
                    right: 14.w,
                    bottom: 8.h,
                    // Rebuilds only this Text every time the bio text changes.
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller.bioController,
                      builder: (context, value, child) {
                        return Text(
                          '${value.text.length} / ${EditProfileController.bioMaxLength}',
                          style: GoogleFonts.dmSans(
                            fontSize: 12.sp,
                            color: AppColors.textMuted,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),
        const Spacer(),
        Obx(
          () => CustomButton(
            text: 'Save changes',
            isLoading: controller.isLoading.value,
            onPressed: controller.saveProfile,
          ),
        ),
      ],
    );
  }

  /// 104px circle (photo or initials) + small dark camera button.
  Widget buildAvatar() {
    return SizedBox(
      width: 104.w,
      height: 104.w,
      child: Stack(
        clipBehavior: Clip.none, // lets the camera button overlap the edge
        children: [
          Obx(() {
            final photo = controller.pickedImage.value;
            return Container(
              width: 104.w,
              height: 104.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                image: photo == null
                    ? null
                    : DecorationImage(
                        image: FileImage(photo),
                        fit: BoxFit.cover,
                      ),
              ),
              // No photo -> show initials of the name typed in the field.
              child: photo != null
                  ? null
                  : ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller.nameController,
                      builder: (context, value, child) {
                        final initials = UserAvatar.initialsOf(value.text);
                        if (initials.isEmpty) {
                          return Icon(
                            Icons.person_outline,
                            size: 44.sp,
                            color: AppColors.surface,
                          );
                        }
                        return Text(
                          initials,
                          style: GoogleFonts.dmSans(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.surface,
                          ),
                        );
                      },
                    ),
            );
          }),
          Positioned(
            right: -2.w,
            bottom: -2.w,
            child: GestureDetector(
              onTap: controller.pickPhoto,
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 3),
                ),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 16.sp,
                  color: AppColors.surface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
