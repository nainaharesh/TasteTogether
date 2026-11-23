// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/views/authentication/welcomescreen.dart';
import 'package:tastetogether/views/profile_screen/edit_profile_screen.dart';
import 'package:tastetogether/views/profile_screen/help_support_screen.dart';
import 'package:tastetogether/views/profile_screen/notification_preference_scree.dart';
import 'package:tastetogether/views/profile_screen/notification_screen.dart';
import 'package:tastetogether/views/profile_screen/settings_screen.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable when local storage is required.
  // await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'TasteTogether',
          debugShowCheckedModeBanner: false,
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
              hintStyle: const TextStyle(color: AppColors.textMuted),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.fieldBorder),
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

          // Initial screen
          home: const NotificationsScreen(),

          // GetX named routes
          getPages: AppPages.pages,

          // Dismiss keyboard when tapping outside
          builder: (context, child) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: child,
            );
          },
        );
      },
    );
  }
}