
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/authentication/auth_viewmodel.dart';
import 'package:tastetogether/views/authentication/login_view.dart';

import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_page_layout.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

/// Screen 3 of 4 - Sign Up.
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  // Creates the controller or reuses the existing registered instance.
  AuthController get controller => Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      children: [
        SizedBox(height: 4.h),

        // Screen heading
        Text(
          'Create account',
          style: GoogleFonts.dmSans(
            fontSize: 32.sp,
            height: 40 / 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.64.sp,
            color: AppColors.textPrimary,
          ),
        ),

        SizedBox(height: 8.h),

        // Screen description
        Text(
          'Join a community of food lovers.',
          style: GoogleFonts.dmSans(
            fontSize: 15.sp,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
        ),

        SizedBox(height: 24.h),

        // Signup form with field validation
        Form(
          key: controller.signupFormKey,
          child: Column(
            children: [
              // Full name field
              CustomTextField(
                label: 'Full name',
                hint: 'Your full name',
                prefixIcon: Icons.person_outline,
                controller: controller.fullNameController,
                validator: controller.validateRequired,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 14.h),

              // Username field
              CustomTextField(
                label: 'Username',
                hint: 'choose_a_username',
                prefixIcon: Icons.alternate_email,
                controller: controller.usernameController,
                validator: controller.validateUsername,
              ),

              SizedBox(height: 14.h),

              // Email field
              CustomTextField(
                label: 'Email',
                hint: 'you@email.com',
                prefixIcon: Icons.mail_outline,
                controller: controller.signupEmailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 14.h),

              // Password field
              CustomTextField(
                label: 'Password',
                hint: 'At least 8 characters',
                prefixIcon: Icons.lock_outline,
                controller: controller.signupPasswordController,
                validator: controller.validateNewPassword,
                isPassword: true,
              ),

              SizedBox(height: 14.h),

              // Confirm password field
              CustomTextField(
                label: 'Confirm password',
                hint: 'Re-enter your password',
                prefixIcon: Icons.lock_outline,
                controller: controller.confirmPasswordController,
                validator: controller.validateSignupConfirmPassword,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => controller.signup(),
              ),
            ],
          ),
        ),

        SizedBox(height: 22.h),

        // Rebuilds the button when the loading state changes.
        Obx(
          () => CustomButton(
            text: 'Create account',
            isLoading: controller.isLoading.value,
            onPressed: controller.signup,
          ),
        ),

        const Spacer(),

        // Navigation to the login screen.
        AuthFooterLink(
          question: 'Already have an account?',
          linkText: 'Log in',
          onTap: () => Get.off(() => LoginScreen()),
        ),
      ],
    );
  }
}
