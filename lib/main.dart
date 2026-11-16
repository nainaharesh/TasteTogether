// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/views/main_application/bottom_navbar.dart';
// import 'package:tastetogether/views/main_application/home_feed.dart';

void main() {
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
        scaffoldBackgroundColor: AppColors.background, // #F8F7F4
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary, // #B65C45
          onPrimary: AppColors.surface, // #FFFFFF
          secondary: AppColors.primaryDeep, // #9E4B36
          surface: AppColors.surface, // #FFFFFF
          onSurface: AppColors.textPrimary, // #292929
          onSurfaceVariant: AppColors.textMuted, // #6B6560
          outline: AppColors.fieldBorder, // #D2B7A3
          outlineVariant: AppColors.border, // #E8D8CA
          surfaceTint: Colors.transparent,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme)
            .apply(
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
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
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
          style: TextButton.styleFrom(foregroundColor: AppColors.primaryDeep),
        ),
      ),
    home: BottomNavbarScreen(),
    );
  }
}