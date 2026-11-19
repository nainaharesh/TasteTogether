import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/appcolors.dart';
import '../../utils/aap_text_styles.dart';

import '../../viewmodels/auth/auth_controller.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_page_layout.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';


/// Screen 4 of 4 - "13 · Forgot Password".
/// It has two views in the design: the email form, and "Check your inbox".
/// The controller's isEmailSent decides which one is shown.
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  AuthController get controller => Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Obx watches isEmailSent and swaps the two views when it changes.
    return Obx(
          () => controller.isEmailSent.value
          ? _buildSentView()
          : _buildFormView(),
    );
  }

  // ---------------------------------------------------------------------------
  // View 1: enter your email
  // ---------------------------------------------------------------------------
  Widget _buildFormView() {
    return AuthPageLayout(
      children: [
        SizedBox(height: 8.h),
        _circleIcon(size: 64, iconSize: 30, icon: Icons.lock_outline),
        SizedBox(height: 20.h),
        Text('Forgot password?', style: AppTextStyles.heading),
        SizedBox(height: 8.h),
        Text(
          "Enter the email linked to your account and we'll send you a link to reset it.",
          style: AppTextStyles.subtitle,
        ),
        SizedBox(height: 28.h),
        Form(
          key: controller.forgotFormKey,
          child: CustomTextField(
            label: 'Email',
            hint: 'you@email.com',
            prefixIcon: Icons.mail_outline,
            controller: controller.forgotEmailController,
            validator: controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => controller.sendResetLink(),
          ),
        ),
        SizedBox(height: 20.h),
        CustomButton(
          text: 'Send reset link',
          isLoading: controller.isLoading.value,
          onPressed: controller.sendResetLink,
        ),
        const Spacer(),
        AuthFooterLink(
          question: 'Remembered it?',
          linkText: 'Log in',
          // Forgot password is always opened from Login, so going back = Login.
          onTap: () => Get.back(),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // View 2: "Check your inbox"
  // ---------------------------------------------------------------------------
  Widget _buildSentView() {
    return AuthPageLayout(
      children: [
        SizedBox(height: 56.h),
        Center(
          child: Column(
            children: [
              _circleIcon(size: 96, iconSize: 42, icon: Icons.mail_outline),
              SizedBox(height: 24.h),
              Text('Check your inbox', style: AppTextStyles.headingMedium),
              SizedBox(height: 8.h),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300.w),
                // RichText lets us make only the email bold.
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.subtitle,
                    children: [
                      const TextSpan(text: 'We sent a reset link to '),
                      TextSpan(
                        text: controller.forgotEmailController.text.trim(),
                        style: AppTextStyles.subtitle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      // BACKEND INTEGRATION: "30 minutes" is copied from the
                      // design. It must match the real expiry time.
                      const TextSpan(text: '. It expires in 30 minutes.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.tint,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 20.sp,
                color: AppColors.textPrimary,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Reset link sent',
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        CustomButton(text: 'Back to log in', onPressed: () => Get.back()),
        SizedBox(height: 8.h),
        Center(
          child: TextButton(
            onPressed: controller.resetForgotPasswordState,
            style: TextButton.styleFrom(minimumSize: Size(0, 44.h)),
            child: Text("Didn't get it? Send again", style: AppTextStyles.link),
          ),
        ),
      ],
    );
  }

  // Round beige circle with an icon (used in both views).
  Widget _circleIcon({
    required double size,
    required double iconSize,
    required IconData icon,
  }) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: const BoxDecoration(
        color: AppColors.tint,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: iconSize.sp, color: AppColors.textPrimary),
    );
  }
}