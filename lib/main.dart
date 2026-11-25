// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/services/token_storage.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/auth_controller.dart';

import 'package:tastetogether/views/authentication/welcomescreen.dart';
import 'package:tastetogether/views/main_application/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenStorage.init();
  // Login / logout / 401 poori app mein isi se chalta hai
  final auth = Get.put(AuthController(), permanent: true);
  runApp(const MyApp());
  // Token ho to profile background mein load (screen ka intezar nahi)
  auth.loadProfile();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TasteTogether',
        // Design mein splash nahi: token hai to seedha Home, warna Welcome
        home: TokenStorage.hasToken ? BottomNavbarScreen() : const WelcomeScreen(),

        // Tablet / web par width 480 tak, text scale 0.9 - 1.2
        builder: (context, child) {
          const maxWidth = 480.0;
          final mq = MediaQuery.of(context);
          final data = mq.copyWith(
            size: Size(mq.size.width.clamp(0, maxWidth), mq.size.height),
            textScaler: mq.textScaler.clamp(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.2,
            ),
          );
          ScreenUtil.configure(data: data);

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ColoredBox(
              color: AppColors.background,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: MediaQuery(data: data, child: child!),
                ),
              ),
            ),
          );
        },

        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            onPrimary: AppColors.surface,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
            outline: AppColors.fieldBorder,
            outlineVariant: AppColors.border,
            surfaceTint: Colors.transparent,
          ),
          textTheme: GoogleFonts.dmSansTextTheme().apply(
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            titleTextStyle: GoogleFonts.dmSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          dividerTheme: const DividerThemeData(
            color: AppColors.border,
            thickness: 1,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(color: AppColors.textMuted),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: AppColors.fieldBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
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
              minimumSize: Size.fromHeight(52.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.primaryDeep),
          ),
        ),
      ),
    );
  }
}
