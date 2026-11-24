import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/aap_text_styles.dart';

import '../../viewmodels/auth/auth_controller.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_page_layout.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';


/// Screen 3 of 4 - "03 · Sign Up".
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  AuthController get controller => Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      children: [
        SizedBox(height: 4.h),
        Text('Create account', style: AppTextStyles.heading),
        SizedBox(height: 8.h),
        Text('Join a community of food lovers.', style: AppTextStyles.subtitle),
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
          onTap: () => Get.offNamed(AppRoutes.login),
        ),
      ],
    );
  }
}