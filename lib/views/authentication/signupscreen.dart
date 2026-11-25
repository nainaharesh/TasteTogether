// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tastetogether/viewmodels/auth_controller.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_page_layout.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/views/authentication/login_view.dart';

/// Screen 3 of 4 - "03 · Sign Up".
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  AuthController get controller => Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      children: [
        SizedBox(height: 4.h),
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

        Form(
          key: controller.signupFormKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Full name',
                hint: 'Your full name',
                prefixIcon: Icons.person_outline,
                controller: controller.signupNameController,
                validator: (v) => controller.validateRequired(v, 'Full name'),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 14.h),
              CustomTextField(
                label: 'Username',
                hint: 'choose_a_username',
                prefixIcon: Icons.alternate_email,
                controller: controller.signupUsernameController,
                validator: controller.validateUsername,
              ),
              SizedBox(height: 14.h),
              CustomTextField(
                label: 'Email',
                hint: 'you@email.com',
                prefixIcon: Icons.mail_outline,
                controller: controller.signupEmailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 14.h),
              CustomTextField(
                label: 'Password',
                hint: 'At least 8 characters',
                prefixIcon: Icons.lock_outline,
                controller: controller.signupPasswordController,
                validator: controller.validateNewPassword,
                isPassword: true,
              ),
              SizedBox(height: 14.h),
              CustomTextField(
                label: 'Confirm password',
                hint: 'Re-enter your password',
                prefixIcon: Icons.lock_outline,
                controller: controller.signupConfirmController,
                validator: controller.validateConfirmPassword,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => controller.signup(),
              ),
            ],
          ),
        ),

        SizedBox(height: 22.h),
        Obx(
          () => CustomButton(
            text: 'Create account',
            isLoading: controller.isLoading.value,
            onPressed: controller.signup,
          ),
        ),

        const Spacer(),
        AuthFooterLink(
          question: 'Already have an account?',
          linkText: 'Log in',
          onTap: () => Get.off(() => LoginScreen()),
        ),
      ],
    );
  }
}
