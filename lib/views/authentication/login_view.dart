// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastetogether/viewmodels/authentication/auth_viewmodel.dart';
import 'package:tastetogether/views/authentication/forgetpasswordscreen.dart';
import 'package:tastetogether/views/authentication/signupscreen.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/widgets/auth/auth_footer_link.dart';
import 'package:tastetogether/widgets/auth/auth_page_layout.dart';
import 'package:tastetogether/widgets/common/app_logo.dart';
import 'package:tastetogether/widgets/common/custom_button.dart';
import 'package:tastetogether/widgets/common/custom_text_field.dart';

/// Screen 2 of 4 - "02 · Login".
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Creates the controller (or reuses it if it already exists)

  AuthController get controller => Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      children: [
        SizedBox(height: 8.h),
        const AppLogo(),
        SizedBox(height: 24.h),
        Text(
          'Welcome back',
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
          'Log in to see what your friends are eating.',
          style: GoogleFonts.dmSans(
            fontSize: 15.sp,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
        ),
        SizedBox(height: 32.h),

        // Form groups the fields so all validators run with one call.
        Form(
          key: controller.loginFormKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Email',
                hint: 'you@email.com',
                prefixIcon: Icons.mail_outline,
                controller: controller.loginEmailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next, // Next key -> password
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Password',
                hint: 'Your password',
                prefixIcon: Icons.lock_outline,
                controller: controller.loginPasswordController,
                validator: controller.validateLoginPassword,
                isPassword: true,
                textInputAction: TextInputAction.done,
                // Pressing "Done" on the keyboard also logs in.
                onFieldSubmitted: (_) => controller.login(),
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.to(() => ForgotPasswordScreen()),
              child: SizedBox(
                height: 44.h,
                child: Center(
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDeep,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Obx rebuilds only this button when isLoading changes.
        Obx(
          () => CustomButton(
            text: 'Log in',
            isLoading: controller.isLoading.value,
            onPressed: controller.login,
          ),
        ),

        const Spacer(),
        AuthFooterLink(
          question: 'New to TasteTogether?',
          linkText: 'Sign up',
          // Replaces the login screen so the Back button does not return to Login.
          onTap: () => Get.off(() => SignupScreen()),
        ),
      ],
    );
  }
}
