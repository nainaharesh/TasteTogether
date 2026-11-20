
 // ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/views/main_application/bottom_navbar.dart';

import 'package:tastetogether/viewmodels/notification_viewmodel.dart';
import 'package:tastetogether/viewmodels/followers_viewmodel.dart';
import 'package:tastetogether/viewmodels/notification_preferences_viewmodel.dart';

void main() {
  Get.put(NotificationsViewModel());
  Get.put(FollowersViewModel());
  Get.put(NotificationPreferencesViewModel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TasteTogether',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          onPrimary: AppColors.surface,
          secondary: AppColors.primaryDeep,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          onSurfaceVariant: AppColors.textMuted,
          outline: AppColors.fieldBorder,
          outlineVariant: AppColors.border,
          surfaceTint: Colors.transparent,
        ),

        textTheme: GoogleFonts.dmSansTextTheme(
          ThemeData.light().textTheme,
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),

        dividerTheme: const DividerThemeData(
          color: AppColors.border,
          thickness: 1,
        ),

        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: AppColors.textMuted,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.fieldBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.surface,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDeep,
          ),
        ),
      ),

      home: BottomNavbarScreen(),
    );
  }
}
