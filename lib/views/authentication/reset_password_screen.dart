// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/authentication/auth_viewmodel.dart';
import 'package:tastetogether/widgets/auth/auth_footer_link.dart';
import 'package:tastetogether/widgets/auth/auth_page_layout.dart';
import 'package:tastetogether/widgets/common/custom_button.dart';
import 'package:tastetogether/widgets/common/custom_text_field.dart';
import 'login_view.dart';


/// Reset Password screen with a reset code and new password fields.
/// Opened from the "Check your inbox" view on the Forgot Password screen.
/// The design follows the Forgot Password screen styling
/// (circle icon, 32/40 title, and 52px high fields and button).
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  AuthController get controller => Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.h,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: const BoxDecoration(
                color: AppColors.border,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 30.sp,
                color: AppColors.textPrimary,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  'Reset password',
                  style: GoogleFonts.dmSans(
                    fontSize: 32.sp,
                    height: 40 / 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.64.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Enter the reset code from your email and choose a new password.',
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            Form(
              key: controller.resetFormKey,
              child: Column(
                spacing: 16.h,
                children: [
                  CustomTextField(
                    label: 'Reset code',
                    hint: 'Paste the code from your email',
                    prefixIcon: Icons.key_outlined,
                    controller: controller.resetTokenController,
                    validator: controller.validateResetToken,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    label: 'New password',
                    hint: 'At least 8 characters',
                    prefixIcon: Icons.lock_outline,
                    controller: controller.resetPasswordController,
                    validator: controller.validateNewPassword,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    label: 'Confirm new password',
                    hint: 'Re-enter your password',
                    prefixIcon: Icons.lock_outline,
                    controller: controller.resetConfirmController,
                    validator: controller.validateConfirmPassword,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => controller.resetPassword(),
                  ),
                ],
              ),
            ),
            // Rebuilds only the button when the loading state changes.
            Obx(
              () => CustomButton(
                text: 'Reset password',
                isLoading: controller.isLoading.value,
                onPressed: controller.resetPassword,
              ),
            ),
          ],
        ),
        const Spacer(),
        AuthFooterLink(
          question: 'Remembered it?',
          linkText: 'Log in',
          onTap: () => Get.offAll(() => LoginScreen()),
        ),
      ],
    );
  }
}
