// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/services/push_notification_service.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/auth/auth_controller.dart';

/// App shuru hote hi: token hai to Home, warna Welcome.
/// Faisla AuthController.checkSession() karta hai, ye screen sirf loader dikhati hai.
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // pehla frame ban jaye, phir navigate (build ke dauran navigate nahi hota)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PushNotificationService.registerDevice(); // login se alag, sirf permission + token
      Get.find<AuthController>().checkSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.h,
          children: [
            Image.asset('assets/icons/logo.png', width: 72.r, height: 72.r),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
