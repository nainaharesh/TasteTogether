import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../viewmodels/auth/auth_controller.dart';
import '../../routes/app_routes.dart';

import '../../utils/aap_text_styles.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/auth/auth_footer_link.dart';
import '../../widgets/auth/auth_page_layout.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';




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
        Text('Welcome back', style: AppTextStyles.heading),
        SizedBox(height: 8.h),
        Text(
          'Log in to see what your friends are eating.',
          style: AppTextStyles.subtitle,
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
          child: InkWell(
            onTap: () => Get.toNamed(AppRoutes.forgotPassword),
            child: SizedBox(
              height: 44.h,
              child: Center(
                child: Text('Forgot password?', style: AppTextStyles.linkSmall),
              ),
            ),
          ),
        ),

        // Obx rebuilds only this button when isLoading changes.
        Obx(
              () => CustomButton(
            text: 'Log in',
            isLoading: controller.isLoading.value,
            onPressed: () => Get.toNamed(AppRoutes.signup),

          ),
        ),

        const Spacer(),
        AuthFooterLink(
          question: 'New to TasteTogether?',
          linkText: 'Sign up',
          // offNamed = replace this screen (so Back from Sign up goes to Welcome)
          onTap: () => Get.offNamed(AppRoutes.signup),
        ),
      ],
    );
  }
}